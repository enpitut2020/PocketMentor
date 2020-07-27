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
  end

  # ツイートする
  # @param [String] Tweet本文
  # @return [nil]
  def send_tweet(tweet_text)
    @client.update(tweet_text)
  end

  # メンション
  # @param [String] Tweet本文
  # @param [Integer] TweetのID
  # @return [nil]
  def mention(tweet_text, tweet_id)
    @client.update(tweet_text, options={:in_reply_to_status_id=>tweet_id})
    puts 'mentioned'
  end

  # リプライ5件を取得
  # @param [nil]
  # @return [nil]
  def getReplies
    @client.mentions_timeline(
        {:count => 5}).each do |tweet|
      printTweet(tweet)
    end
  end

  # Tweetを表示
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
    @client.mentions_timeline(
      {:count => count}).each do |tweet|
        phrase = removeUserName(tweet)
        hash = @gcs.search(phrase, num=1, output=true)
        message = createRecommendMessage(hash)
        reply_message = addUserName(message, tweet.user.screen_name)
        mention(reply_message, tweet.id)
    end
  end

  # ツイート本文から@MentorPocketを取り除く
  # @param [String] ツイート本文（ツイートオブジェクト）
  # @return [String] ユーザ名が取り除かれたツイート本文
  def removeUserName(tweet)
    # return tweet.text.gsub(/\@MentorPocket/, "@#{tweet.user.screen_name}") 
    # ^\n  
    return tweet.text.gsub(/\@MentorPocket/, "")
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

end
