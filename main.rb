require './twitter_client'
require './firestore_client'
twitter_client = TwitterClient.new()
# twitter_client.sendReplies(2)

firestore_client = FirestoreClient.new()
tweets = twitter_client.getReplies
# puts tweets
tweets.each do | tweet | 
    firestore_client.saveUser(tweet)
    firestore_client.saveTweet(tweet)
end