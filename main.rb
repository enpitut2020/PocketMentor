require './twitter_client'
require './google_api'
require './firestore_client'

twitter_client = TwitterClient.new()
firestore_client = FirestoreClient.new()


SLEEP_TIME = 1 * 60

loop {
  # # 暇ツイートパート
  twitter_client.reloadRecentTweetId()
  boredTweets = twitter_client.getBoredTweets()
  if boredTweets.empty?
    puts "暇ツイートはありません．"
    puts "みんな忙しそう"
  else
    twitter_client.setRecentTweet(boredTweets[0].id) unless boredTweets[0].nil?
    boredTweets.reverse_each do |tweet|
      # recent_wish_doc = firestore_client.getUserRecentWishTweet(tweet.user.id)
      # message = twitter_client.createRecommendMessageFromText(recent_wish_doc[:tweet])
      # reply_message = twitter_client.addUserName(message, tweet.user.screen_name)
      # twitter_client.mention(reply_message, tweet.id)
      puts tweet.id
      puts tweet.user.screen_name
      puts tweet.text + "\n"
    end
  end
  # メンション処理パート
  # リプライを取得
  twitter_client.reloadRecentReplyId()
  replies= twitter_client.getReplies()
  twitter_client.setRecentReply(replies[0].id) unless replies[0].nil?

  replies.each do |reply|
    #リプライをfirestoreに保存
    firestore_client.saveUser(reply)
    firestore_client.saveTweet(reply)

    #保存しましたみたいなことをリプする。
    twitter_client.sendSavingMessage(reply)
  end
  # スリープ
  sleep(SLEEP_TIME)
}
