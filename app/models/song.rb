class Song
  include Mongoid::Document
  include Mongoid::Timestamps
  include Mongoid::CounterCache
  
  field :name
  field :lyrics
  field :description
  field :url
  field :exp
  
  has_many :contributions
  has_many :activities
  has_one :photo
  belongs_to :album
  belongs_to :idol
  
  counter_cache :name => :idol, :inverse_of => :songs
  def mp3_url
    self.url.blank? ? "#" : self.upyun_url + self.url
  end

  protected

  def upyun_url
    "http://guanghe-file.b0.upaiyun.com"
  end
  
end