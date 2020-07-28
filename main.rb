require './twitter_client'
require './google_api'
require './firestore_client'

SLEEP_TIME = 2 * 60

loop {
  # Twitterインスタンス
  twitter_client = TwitterClient.new()
  boredTweets = twitter_client.getBoredTweets()
  if boredTweets.empty?
    puts "暇ツイートはありません．"
    puts "みんな忙しそう"
  else
    boredTweets.each do |tweet|
      puts tweet.user.screen_name
      puts tweet.text
    end
    twitter_client.setRecentTweet(boredTweets[0].id)
  end

  sleep(SLEEP_TIME)
}
