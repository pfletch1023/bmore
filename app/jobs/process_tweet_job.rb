class ProcessTweetJob < ActiveJob::Base
  queue_as :default

  def perform(tweet)
    print "PROCESSING #{tweet[:text]}\n"
    # tweet.set_images_from_hash
    # tweet.set_words
    Tweet.create_from_hash(tweet)
  end
end
