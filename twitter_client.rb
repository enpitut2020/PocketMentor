require "twitter"
require "dotenv"
require "uri"
require "./google_api"
Dotenv.load

# Twitterアカウントを操作するクラス
class TwitterClient

  def initialize()
    # twitter client
    @client = Twitter::REST::Client.new do |config|
      config.consumer_key        = ENV["CONSUMER_KEY"]
      config.consumer_secret     = ENV["CONSUMER_SECRET"]
      config.access_token        = ENV["ACCESS_TOKEN"]
      config.access_token_secret = ENV["ACCESS_TOKEN_SECRET"]
    end

    # google api instance
    @gcs = MyGoogleCustomSearcher.new

    @recentTweetId = getRecentTweet()
  end

  # ツイートする
  # @param [String] Tweet本文
  # @return [nil]
  def send_tweet(tweet_text)
    @client.update(tweet_text)
  end

  # メンションする
  # @param [String] Tweet本文
  # @param [Integer] TweetのID
  # @return [nil]
  def mention(tweet_text, tweet_id)
    @client.update(tweet_text, options={:in_reply_to_status_id=>tweet_id})
    puts 'mentioned'
  end

  # リプライn件を取得する
  # @param [Int] 何件取得するか
  # @return [array] Twittetオブジェクトn件
  def getReplies(cnt=5)
    tweets=[]
    @client.mentions_timeline(
        {:count => cnt} ).each do |tweet|
      tweets.push(tweet)
    end
    return tweets
  end

  # Tweetをコンソール表示(ユーザ名 @名前 ツイート内容)
  # @param [tweet] ツイートオブジェクト
  # @return なし
  def printTweet(tweet)
      puts "\e[33m" + tweet.user.name + "\e[32m" + "[ID:" + tweet.user.screen_name + "]"
      puts "\e[0m" + tweet.text
  end

  # リプライを送信
  # @param [Integer] count 返信個数
  # @return [nil]
  def sendReplies(count)
    replies = getReplies(count)
    replies.each do |tweet|
      reply_message = formatReply(tweet)
      mention(reply_message, tweet.id)
    end
  end

  # リプライの形に整形
  # @param [String] ツイートオブジェクト
  # @return [String] リプライするツイート本文
  def formatReply(tweet)
    phrase = removeUserName(tweet.text)
    hash = @gcs.search(phrase, num=1, output=false)
    message = createRecommendMessage(hash)
    reply_message = addUserName(message, tweet.user.screen_name)
    return reply_message
  end

  # 入力したテキストから@MentorPocketを取り除く
  # @param [String] ツイート本文（ツイートオブジェクト）
  # @return [String] ユーザ名が取り除かれたツイート本文
  def createRecommendMessageFromText(tweet_text)
    phrase = removeUserName(tweet_text)
    hash = @gcs.search(phrase, num=1, output=false)
    message = createRecommendMessage(hash)
    return message
  end

  # ツイート本文から@MentorPocketを取り除く
  # @param [String] ツイート本文（ツイートオブジェクト）
  # @return [String] ユーザ名が取り除かれたツイート本文
  def removeUserName(text)
    return text.gsub(/\@MentorPocket/, "")
  end

  # ツイート本文の末尾に送信者のユーザー名をつける
  # @param [String] ツイートテキスト
  # @param [String] 送信者のユーザー名
  # @return [String] 末尾にユーザー名のついたツイート本文
  def addUserName(tweet_text, user_name)
    return "#{tweet_text}\n@#{user_name}"
  end

  # google_apiからhashを受け取って，リプライメッセージを作成する
  # @param [hash] 検索後のハッシュ
  # @return [String] 検索結果ツイート本文
  def createRecommendMessage(hash)
    message = "あなたへのおススメ記事はこれ！\n"
    hash["items"].each do |item|
        message << "#{item["title"]}\n" 
        message << "#{item["link"]}\n"
    end
    return message
  end
  
  # 「ひま」と呟いたツイートを取得する
  # @param [Integer] count 取得する数
  # @return [Array] boredTweets 暇ツイートオブジェクトの配列
  def getBoredTweets()
    recentTweets = @client.home_timeline({:since_id => @recentTweetId})
    if recentTweets == nil
      return nil
    end
    boredTweets = []
    recentTweets.each do |tweet|
      if tweet.text =~ /暇/ and tweet.user.screen_name != "MentorPocket"
        boredTweets << tweet
      end
    end
    return boredTweets
  end

  # 一番新しいツイートIDを取得する
  # @param [nil] 
  # @return [Integer] tweetId ツイートID　
  def getRecentTweet()
    tweetId = File.read(".recentTweetId.log").to_i
    return tweetId
  end

  # 一番新しいツイートIDを保存する
  # @param [Integer] tweetId ツイートID
  # @return [nil]
  def setRecentTweet(tweetId)
    File.open(".recentTweetId.log", 'w') do |file|
      file.write(tweetId)
    end
  end

end
