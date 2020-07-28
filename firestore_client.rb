# require 'google/apis/firestore_v1beta1'
require 'net/http'
require 'dotenv'
Dotenv.load
require "google/cloud/firestore"


class FirestoreClient

  # インスタンスを作成
  # @param [nil] 
  # @return [nil]
  def initialize()    
    @firestore_client = Google::Cloud::Firestore.new(
      project_id: "pocketmentor-455ae",
      credentials: "pocketmentor-455ae-firebase-adminsdk-bw1dg-9626bcc8d7.json"
    )
  end

  # ない場合は新規作成される
  # ある場合は更新される
  # users/tweet_id(不変ID)/ここ更新
  # @param [Object] Tweetオブジェクト 
  # @return [nil]
  def saveUser(tweet)
    doc_ref = @firestore_client.doc "users/#{tweet.user.id}"
    doc_ref.set(
      screen_name: tweet.user.screen_name
    )
  end

  # ~したいの最初のツイートを保存
  # ない場合は新規作成されるある場合は更新される
  # users/twitter_id/tweets/tweetのID/ここを更新
  # @param [Object] Tweetオブジェクト 
  # @return [nil]
  def saveTweet(tweet)
    tweet_ref = @firestore_client.doc "users/#{tweet.user.id}/tweets/#{tweet.user.id}"
    tweet_ref.set(
      tweet: tweet.text,
    )
  end

  # botのリプライを保存する
  # リプライ先のツイートの直に下保存する
  # users/twitter_id/tweets/tweetのID/replies/ここを更新
  # @param [Object] Tweetオブジェクト 
  # @return [nil]
  def saveReply(tweet)
    reply_ref = @firestore_client.doc "users/#{tweet.user.id}/tweets/#{tweet.user.id}/replies/#{tweet.id}"
    reply_ref.set(
      tweet: tweet.text,
    )
  end


  # ユーザーが呟いた全てのやりたいことツイート
  # リプライ先のツイートの直に下保存する
  # @param [user_id] user_id (tweet.user.id)不変のid
  # @return [Object] firestoreに保存してるツイートオブジェクト
  # tweet.data →{tweet: "tweet text"}
  def getTweets(user_id)
    tweets_ref = @firestore_client.col "users/#{user_id}/tweets"
    tweets=[]
    tweets_ref.get do |tweet|
      # puts "#{tweet.document_id} data: #{tweet.data}."
      tweets.push(tweet.data)
    end
    return tweets
  end

end