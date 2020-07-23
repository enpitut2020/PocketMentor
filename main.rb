require './twitter_client'

client = TwitterClient.new()

puts client.getReplies()
