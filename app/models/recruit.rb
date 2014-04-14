class Recruit
  include Mongoid::Document
  include Mongoid::Timestamps
  
  field :name
  field :wechat
  field :it_ability
  field :mkt_ability
  field :other_ability
  field :code
  field :ten_answer
  field :more_answer
  field :last_answer
  
  validates_presence_of :name, :wechat
  
  before_create :create_invite_token
  def create_invite_token
    str1 = ["热血", "聪明", "放荡", "勇敢", "刚烈", "汹涌"].sample
    str2 = ["土豪", "神奇", "逗比", "超级", "无敌"].sample
    str3 = ["小", "大", "破", "老", "金"].sample
    str4 = ["耳机", "音箱", "话筒", "电脑", "声卡", "鼠标", "屁股"].sample
    self.code = str1 + "的" + str2 + str3 + str4
  end
  
end