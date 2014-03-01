class Floor
  include Mongoid::Document
  include Mongoid::Timestamps
  
  field :index
  field :elapsed_time
  
  belongs_to :contribution
  belongs_to :user
  belongs_to :activity
  
end