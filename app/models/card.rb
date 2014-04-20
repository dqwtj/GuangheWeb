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
  
  def get_upgrade_target
    case self.quality
    when 0
      1000
    when 1
      3000
    when 2
      7000
    when 3
      12000
    else
      99999999
    end    
  end
end