class ProcessTweetJob < ActiveJob::Base
  queue_as :default

  def perform(tweet)
    print "PROCESSING #{tweet[:text]}\n"
    Tweet.create_from_hash(tweet)
  end
end
