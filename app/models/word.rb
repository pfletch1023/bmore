class Word
  include Mongoid::Document

  # Fields
  field :string, type: String
  field :tweets_count, type: Integer, default: 0

  # Validations
  validates_presence_of :string
  validates_uniqueness_of :string

  # Associations
  has_and_belongs_to_many :tweets, index: true

  # Callbacks
  after_save :update_tweets_count

  # Scopes
  scope :most_popular, -> { order_by(tweets_count: :desc) }

  # Instance methods
  def update_tweets_count
    len = tweets.length
    update_attributes(tweets_count: len) unless tweets_count == len
  end

end
