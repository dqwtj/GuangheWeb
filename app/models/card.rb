class Card
  include Mongoid::Document
  include Mongoid::Timestamps
  #white, green, blue, purple
  field :quality
  field :is_updating
  field :update_start_time
  #人气值
  field :pop_number
  embeds_one :chip
  belongs_to :song
  
end