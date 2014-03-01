class Activity
  include Mongoid::Document
  include Mongoid::Timestamps
  
  field :max_floor
  field :start_time
  field :end_time
  field :a_type
  field :description
  field :exp
  
  has_many :floors
  belongs_to :song
  
  
end