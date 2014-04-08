class Card
  include Mongoid::Document
  include Mongoid::Timestamps
  #white, green, blue, purple
  field :quality
  field :is_creating
  #人气值
  field :pop_number
  has_many :chip
  belongs_to :song
end