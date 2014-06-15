class Song
  include Mongoid::Document
  include Mongoid::Timestamps
  include Mongoid::CounterCache
  
  field :name
  field :lyrics
  field :description
  field :url
  field :cardpicurl
  field :exp
  field :level,      :type => Integer, :default => 0
  field :ticket
  field :sceneid
  
  has_many :contributions
  has_many :activities
  has_one :photo
  belongs_to :album
  belongs_to :idol
  has_many :cards
  counter_cache :name => :idol, :inverse_of => :songs
  def card_pic_url
    self.cardpicurl.blank? ? 'http://guanghe-photo.b0.upaiyun.com/avatar/4b7dca79dd618be9ea5c93edd1ed71a6.png!avatarsmall' : self.upyun_photo_url + self.cardpicurl + '!card'
  end
  
  def mp3_url
    self.url.blank? ? "#" : self.upyun_url + self.url
  end
  
  def qrcode_url
    self.ticket.blank? ? "#" : "https://mp.weixin.qq.com/cgi-bin/showqrcode?ticket=" + self.ticket
  end

  protected

  def upyun_url
    "http://guanghe-file.b0.upaiyun.com"
  end
  
  def upyun_photo_url
    "http://guanghe-photo.b0.upaiyun.com"
  end  
end