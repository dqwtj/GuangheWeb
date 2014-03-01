class Apply
  include Mongoid::Document
  include Mongoid::Timestamps
  
  field :name
  field :gender
  field :email
  field :wechat
  field :douban_url
  field :weibo_url
  field :wusing_url
  field :other_url
  field :description
  field :similar_artist
  field :invite_token
  
  validates_presence_of :name, :gender, :email, :wechat
  
  validates_uniqueness_of :email
  
  
  before_create :create_invite_token
  def create_invite_token
    self.invite_token = self.created_at.to_i.to_s(16)
  end
  
end