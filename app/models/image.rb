class Image
  include Mongoid::Document

  # Fields
  field :url, type: String
  field :type, type: String

  # Associations
  belongs_to :tweet

  # Validations
  validates_presence_of :url, :type

  def self.create_from_hash(hash, tweet)
    create(url: hash[:media_url], type: hash[:type], tweet: tweet)
  end
end
