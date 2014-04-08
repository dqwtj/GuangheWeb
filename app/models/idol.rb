class Idol
  include Mongoid::Document
  include Mongoid::Timestamps

  # Include default devise modules. Others available are:
  # :token_authenticatable, :confirmable,
  # :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  ## Database authenticatable
  field :email,              :type => String, :default => ""
  field :encrypted_password, :type => String, :default => ""

  ## Recoverable
  field :reset_password_token,   :type => String
  field :reset_password_sent_at, :type => Time

  ## Rememberable
  field :remember_created_at, :type => Time

  ## Trackable
  field :sign_in_count,      :type => Integer, :default => 0
  field :current_sign_in_at, :type => Time
  field :last_sign_in_at,    :type => Time
  field :current_sign_in_ip, :type => String
  field :last_sign_in_ip,    :type => String

  ## Confirmable
  # field :confirmation_token,   :type => String
  # field :confirmed_at,         :type => Time
  # field :confirmation_sent_at, :type => Time
  # field :unconfirmed_email,    :type => String # Only if using reconfirmable

  ## Lockable
  # field :failed_attempts, :type => Integer, :default => 0 # Only if lock strategy is :failed_attempts
  # field :unlock_token,    :type => String # Only if unlock strategy is :email or :both
  # field :locked_at,       :type => Time

  ## Token authenticatable
  # field :authentication_token, :type => String
  field :name
  field :level
  #入驻音乐人, etc
  field :title
  field :exp
  field :balance
  field :invite_token,  :type => String, :default => ""
  field :name
  field :gender, :type=> String, :default => "男"
  field :wechat
  field :avatar_url
  field :douban_url
  field :weibo_url
  field :wusing_url
  field :other_url
  field :description
  field :similar_artist

  field :songs_count, :type => Integer, :default => 0

  has_many :contributions
  has_many :songs
  has_many :albums
  has_many :tasks
  has_and_belongs_to_many :fans, :class_name => 'User', :inverse_of => :idols

  validates_each :email do |record, attr, value|
    @apply = Apply.where(:email => value).first
    if @apply == nil
      record.errors.add(attr, '您输入的Email不存在，请先申请内测，等我们工作人员联系您后再来注册')
    end
  end

  validate :valid_invite_token

  def valid_invite_token
    @apply = Apply.where(invite_token: invite_token).first
    if @apply == nil
      errors.add(:invite_token, '您输入的邀请码和Email不匹配，请重新输入')
    end
  end

  def avatar_small
    self.avatar_url.blank? ? "#" : self.upyun_url+self.avatar_url+"!avatarsmall"
  end

  protected

  def upyun_url
    "http://guanghe-photo.b0.upaiyun.com"
  end

end