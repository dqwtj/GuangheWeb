class Slot
  include Mongoid::Document
  include Mongoid::Timestamps
  field :chip_count, :default => 0
  field :card_count, :default => 0
  belongs_to :card
  belongs_to :user
  
end