class Recruit
  include Mongoid::Document
  include Mongoid::Timestamps
  
  field :name
  field :wechat
  field :it_ability
  field :mkt_ability
  field :other_ability
  
  validates_presence_of :name, :wechat
  
end