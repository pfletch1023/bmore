class Word
  include Mongoid::Document

  # Fields
  field :string, type: String

  # Validations
  validates_presence_of :string
  validates_uniqueness_of :string

  # Associations
  has_and_belongs_to_many :tweets
  field :tweets_count, type: Integer, default: 0

end
