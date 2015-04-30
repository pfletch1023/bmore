class Tweet
  include Mongoid::Document

  # Fields
  field :text, type: String
  field :raw, type: Hash
  field :tags, type: Array
  field :time, type: DateTime
  field :word_bag, type: Array
  field :is_retweet, type: Boolean
  field :tid, type: String
  has_and_belongs_to_many :words, index: true

  # Associations
  belongs_to :user
  has_many :images

  # Validations
  validates_presence_of :text, :user_id, :time

  # Callbacks
  # after_create :post_process
  after_create :set_words

  # Instance methods
  def word_bag_from_text
    # Init string
    string = text.downcase

    # Remove urls from string
    string.gsub!(/(?:f|ht)tps?:\/[^\s]+/, '')

    # Remove html strings
    string.gsub!(/&\w+;/, '')

    # Remove RT, @, # words
    string.gsub!(/rt|[\@\#]\w+/, '')

    # Remove punctuation
    string.gsub!(/[^a-z0-9\s]/i, '')

    # Stops
    stops = $stop_words + ["baltimore"]

    # Return array
    return string.split - stops
  end

  def tweet_url
    begin
      if tid and tweet = $twitter_rest_client.status(tid)
        return tweet.url.to_s
      end
    rescue
    end
  end

  # Class methods
  def self.tags_from_hash(hash)
    return hash[:entities][:hashtags].map { |t| t[:text] }
  end

  def self.create_from_hash(hash)
    tags = tags_from_hash(hash)
    user = User.create_from_hash(hash[:user])
    create(text: hash[:text], tags: tags, user: user, 
      time: hash[:created_at], tid: hash[:id_str])
  end

  def self.stream(tracks, args = {})
    tracks = [tracks] unless tracks.is_a?(Array)
    $twitter_client.track(*tracks) do |status|
      if status.lang == "en" and !status.retweeted_status?
        Tweet.create_from_hash(status.to_hash)
      end
    end
  end

  def set_words
    word_bag_from_text.each do |w|
      self.words << Word.find_or_create_by(string: w)
    end
  end

  private

  def post_process
    ProcessTweetJob.perform_later(self)
  end
 
end
