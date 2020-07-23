require "twitter"
require "dotenv"
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
  def tweet(str)
    @client.update(str)
  end

  # メンションする
  # @param [String] Tweet本文
  # @param [Integer] TweetのID
  # @return [nil]
  def mention(str, tweet_id)
    @client.update(str, options={:in_reply_to_status_id=>tweet_id})
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
  # @param [tweet] １ツイート
  # @return なし
  def printTweet(tweet)
      puts "\e[33m" + tweet.user.name + "\e[32m" + "[ID:" + tweet.user.screen_name + "]"
      puts "\e[0m" + tweet.text
  end

  # おうむ返しをします
  # @param [Integer] count 返信個数
  # @return [nil]
  def sendReplies(count)
    @client.mentions_timeline(
        {:count => count}).each do |tweet|
            reply_message = tweet.text.gsub(/\@MentorPocket/, "@#{tweet.user.screen_name}")    
            puts reply_message
            # tweet(reply_message)
            mention(reply_message,tweet.id)
    end
  end

end
