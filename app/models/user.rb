class User
  include Mongoid::Document

  # Fields
  field :screen_name, type: String
  field :name, type: String
  field :tid, type: String
  field :description, type: String
  field :location, type: String

  # Associations
  has_many :tweets

  # Validations
  validates_presence_of :name, :tid, :location

  # Class methods
  def self.create_from_hash(hash)
    user = find_or_initialize_by(tid: hash[:id_str])
    unless user.valid?
      create(
        tid: hash[:id_str],
        name: hash[:name],
        screen_name: hash[:screen_name],
        description: hash[:description],
        location: hash[:location]
      )
    end
  end

end
