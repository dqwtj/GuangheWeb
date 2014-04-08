class Slot
  include Mongoid::Document
  include Mongoid::Timestamps
  field :chip_count
  field :card_count
  belongs_to :card
  belongs_to :user
  
end