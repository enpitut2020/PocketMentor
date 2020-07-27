require './twitter_client'

client = TwitterClient.new()

loop {
    client.send_tweet(Time.new)
    one_minites = 1 * 60
    sleep(one_minites)
}
