require "twitter"
require "dotenv"
Dotenv.load

class TwitterClient

  def initialize()
    @client = Twitter::REST::Client.new do |config|
      config.consumer_key        = ENV["CONSUMER_KEY"]
      config.consumer_secret     = ENV["CONSUMER_SECRET"]
      config.access_token        = ENV["ACCESS_TOKEN"]
      config.access_token_secret = ENV["ACCESS_TOKEN_SECRET"]
    end
  end

  def tweet(str)
    @client.update(str)
  end

  def getReply
    @client.mentions_timeline.each do |tweet|
      puts "\e[33m" + tweet.user.name + "\e[32m" + "[ID:" + tweet.user.screen_name + "]"
      puts "\e[0m" + tweet.text
    end
  end

end

#main 
if __FILE__ == $0
    client = TwitterClient.new()
    # client.tweet("tweet from api")
    client.getReply
end
