namespace :tweetstream do
  desc "TODO"
  task work: :environment do
    Tweet.stream(["Baltimore", "BaltimoreRiots", "BaltimoreUprising"])
  end
end
