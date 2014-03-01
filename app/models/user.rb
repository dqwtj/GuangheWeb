class User
  include Mongoid::Document
  include Mongoid::Timestamps
  
  field :exp
  field :level
  field :balance
  
  has_many :contributions
  has_many :floors
  has_and_belongs_to_many :idols, :inverse_of => :fans
  
end