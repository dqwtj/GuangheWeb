class Wechatlog
  include Mongoid::Document
  include Mongoid::Timestamps
  field :fromUser
  field :content
  field :type
  field :time
  field :mediaId
  field :createTime
  field :event
  field :params
end
