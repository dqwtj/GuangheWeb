class Chip
  include Mongoid::Document
  include Mongoid::Timestamps
  field :count
  embedded_in :card
  belongs_to :user
  
end