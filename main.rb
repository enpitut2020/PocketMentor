require './twitter_client'
require './google_api'

# Twitterインスタンス
client = TwitterClient.new()
client.sendReplies(1)
