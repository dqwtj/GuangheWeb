class Contribution
  include Mongoid::Document
  include Mongoid::Timestamps
  
  field :value, :type => Integer, :default => 0
  field :exp, :type => Integer, :default => 0
  field :c_type
  
  belongs_to :idol
  belongs_to :song
  belongs_to :user
  has_one :floor
    
end