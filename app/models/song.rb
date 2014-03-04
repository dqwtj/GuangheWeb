class Song
  include Mongoid::Document
  include Mongoid::Timestamps
  include Mongoid::CounterCache
  
  field :name
  field :lyrics
  field :description
  field :url
  field :exp
  
  has_many :contributions
  has_many :activities
  has_one :photo
  belongs_to :album
  belongs_to :idol
  
  counter_cache :name => :idol, :inverse_of => :songs
  
end