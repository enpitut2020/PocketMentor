require './twitter_client'
require './google_api'
require './firestore_client'

# Firestoreの動作確認
# Twitterインスタンス
twitter_client = TwitterClient.new()
firestore_client = FirestoreClient.new()


SLEEP_TIME = 30

loop {
  # # 暇ツイートパート
  # boredTweets = twitter_client.getBoredTweets()
  # if boredTweets.empty?
  #   puts "暇ツイートはありません．"
  #   puts "みんな忙しそう"
  # else
  #   boredTweets.each do |tweet|
  #     #暇と呟いたユーザーのツイートたち　の配列
  #     firestore_client.getUserAllWishTweet(tweet.user.id)
  #     # ツイート渡す
  #     # やりたいことを1こ受け取る
  #     # 記事をmention
  #   end
  #   twitter_client.setRecentTweet(boredTweets[0].id) unless boredTweets[0].nil?
  # end

  # メンション処理パート
  # リプライを取得
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