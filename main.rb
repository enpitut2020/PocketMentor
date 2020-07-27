require './twitter_client'
require './google_api'

# Twitterインスタンス
client = TwitterClient.new()
# GoogleCustomSearchインスタンス
gcs = MyGoogleCustomSearcher.new()

phrase = '海鮮丼　作り方' 
hash = gcs.search(phrase, num=1, output=true)
message = client.createRecommendMessage(hash)
client.send_tweet(message)
