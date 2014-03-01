class Song
  include Mongoid::Document
  include Mongoid::Timestamps
  
  field :name
  field :lyrics
  field :exp
  
  has_many :contributions
  has_many :activities
  has_one :photo
  belongs_to :album
  belongs_to :idol
  
end