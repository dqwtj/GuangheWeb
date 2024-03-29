class User
  include Mongoid::Document
  include Mongoid::Timestamps
  
  field :exp
  field :level
  field :balance
  field :hp
  field :last_recovery_time
  field :recovery_duration
  field :fromUser
  field :info
  field :last_active_time
  
  has_many :contributions
  has_many :floors
  has_many :slots
  has_and_belongs_to_many :idols, :inverse_of => :fans
  
end