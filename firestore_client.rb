# require 'google/apis/firestore_v1beta1'
require 'net/http'
require 'dotenv'
Dotenv.load
require "google/cloud/firestore"


class FirestoreClient

  def initialize()    
    @firestore_client = Google::Cloud::Firestore.new(
      project_id: "pocketmentor-455ae",
      credentials: "pocketmentor-455ae-firebase-adminsdk-bw1dg-9626bcc8d7.json"
    )
  end

  #ない場合は新規作成される
  #ある場合は更新される
  def saveUser(tweet)
    doc_ref = @firestore_client.doc "users/#{tweet.user.id}"
    doc_ref.set(
      screen_name: tweet.user.screen_name
    )
  end

  def saveTweet(tweet)
    tweet_ref = @firestore_client.doc "users/#{tweet.user.id}/tweets/#{tweet.user.id}"
    tweet_ref.set(
      tweet: tweet.text,
    )
  end

  #botのリプライを保存する
  #リプライ先のツイートの直に下保存する
  def saveReply(tweet)
    reply_ref = @firestore_client.doc "users/#{tweet.user.id}/tweets/#{tweet.user.id}/replies/aaaa"
    reply_ref.set(
      tweet: tweet.text,
    )
  end
end