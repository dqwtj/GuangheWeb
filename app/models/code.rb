class Code
  include Mongoid::Document
  include Mongoid::Timestamps
  field :code
  field :song
  field :is_used
  has_one :idol
  has_one :user
end