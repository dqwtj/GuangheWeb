class Code
  include Mongoid::Document
  include Mongoid::Timestamps
  
  has_many :songs
  belongs_to :idol
  
end