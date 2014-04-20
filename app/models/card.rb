class Card
  include Mongoid::Document
  include Mongoid::Timestamps
  #white, green, blue, purple
  field :quality
  field :is_creating
  #人气值
  field :pop_number
  has_many :slot
  belongs_to :song
  belongs_to :idol
  def get_quality_name
    case self.quality
    when 0
      "white"
    when 1
      "green"
    when 2
      "blue"
    when 3
      "purple"
    else
      "unknown"
    end
  end
end