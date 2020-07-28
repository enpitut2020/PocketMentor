require './twitter_client'
require './google_api'
require './firestore_client'

twitter_client = TwitterClient.new()
firestore_client = FirestoreClient.new()

SLEEP_TIME = 2 * 60

loop {
  boredTweets = twitter_client.getBoredTweets()
  if boredTweets.empty?
    puts "暇ツイートはありません．"
    puts "みんな忙しそう"
  else
    twitter_client.setRecentTweet(boredTweets[0].id) unless boredTweets[0].nil?
    boredTweets.each do |tweet|
      recent_wish_doc = firestore_client.getUserRecentWishTweet(tweet.user.id)
      message = twitter_client.createRecommendMessageFromText(recent_wish_doc[:tweet])
      reply_message = twitter_client.addUserName(message, tweet.user.screen_name)
      twitter_client.mention(reply_message, tweet.id)
    end
  end

  # スリープ
  sleep(SLEEP_TIME)
}