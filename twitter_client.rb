require "twitter"
require "dotenv"
require "uri"
Dotenv.load

# Twitterアカウントを操作するクラス
class TwitterClient

  def initialize()
    @client = Twitter::REST::Client.new do |config|
      config.consumer_key        = ENV["CONSUMER_KEY"]
      config.consumer_secret     = ENV["CONSUMER_SECRET"]
      config.access_token        = ENV["ACCESS_TOKEN"]
      config.access_token_secret = ENV["ACCESS_TOKEN_SECRET"]
    end
  end

  # ツイートをします
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
  end

  # リプライ5件を取得する
  # @param [nil]
  # @return [nil]
  def getReplies
    @client.mentions_timeline(
        {:count => 5}).each do |tweet|
      printTweet(tweet)
    end
  end

  # Tweetを表示します
  # @param [tweet] ツイートオブジェクト
  # @return なし
  def printTweet(tweet)
      puts "\e[33m" + tweet.user.name + "\e[32m" + "[ID:" + tweet.user.screen_name + "]"
      puts "\e[0m" + tweet.text
  end

  # リプライを送信します。
  # @param [Integer] count 返信個数
  # @return [nil]
  def sendReplies(count)
    @client.mentions_timeline(
        {:count => count}).each do |tweet|
            search_word = removeUserName(tweet)
            # search_word = removeInvalidChar(search_word)
            puts search_word
            # send_tweet(reply_message)
            query = URI.encode_www_form(q: search_word)
            uri = "https://www.google.com/search?#{query}"
            puts uri
            reply_message = addUserName(uri,tweet.user.screen_name)
            puts reply_message
            mention(reply_message, tweet.id)
    end
  end

  # ツイート本文から@MentorPocketを取り除きます
  # @param [String] ツイート本文（ツイートオブジェクト）
  # @return [String] ユーザ名が取り除かれたツイート本文
  def removeUserName(tweet)
    # return tweet.text.gsub(/\@MentorPocket/, "@#{tweet.user.screen_name}") 
    # ^\n  
    return tweet.text.gsub(/\@MentorPocket/, "")
  end

  # ツイート本文の末尾に送信者のユーザー名をつけます
  # @param [String] ツイートテキスト
  # @param [String] 送信者のユーザー名
  # @return [String] 末尾にユーザー名のついたツイート本文
  def addUserName(tweet_text, user_name)
    return "#{tweet_text}\n@#{user_name}"
  end

end
