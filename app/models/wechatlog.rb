class Wechatlog
  include Mongoid::Document
  include Mongoid::Timestamps
  field :fromUser
  field :content
  field :type
  field :time
  field :MediaId
  field :CreateTime
  field :event
end
