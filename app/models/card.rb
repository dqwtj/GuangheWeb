class Card
  include Mongoid::Document
  include Mongoid::Timestamps
  #white, green, blue, purple
  field :quality, :default => 0
  field :is_creating, :default => true
  field :is_upgraded, :default => false
  #人气值
  field :pop_number, :default => 0
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
  
  def get_creating_time
    case self.quality
    when 0
      0
    when 1
      1000
    when 2
      2000
    when 3
      4000
    else
      99999999
    end
  end
  
  def get_remaining_time
    (get_creating_time - (Time.now - self.created_at)).round
  end
  
  def add_one_popnumber
    self.inc(:pop_number => 1)
    self.song.idol.inc(:pop_number => 1)
  end
end