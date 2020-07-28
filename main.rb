require './twitter_client'
require './google_api'

# Twitterインスタンス
client = TwitterClient.new()
boredTweets = client.getBoredTweets(2)
boredTweets.each do |tweet|
    puts tweet.user.screen_name
    puts tweet.text
end
client.setRecentTweet(boredTweets[0].id)
