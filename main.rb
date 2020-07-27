require './twitter_client'
require './google_api'

# Twitterインスタンス
client = TwitterClient.new()
# GoogleCustomSearchインスタンス
gcs = MyGoogleCustomSearcher.new()

phrase = 'ビーフストロガノフ' 
hash = gcs.search(phrase, num=3, output=true)
puts hash
message = client.createRecommendMessage(hash)
puts message
client.send_tweet(message)
