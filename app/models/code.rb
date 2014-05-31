class Album
  include Mongoid::Document
  include Mongoid::Timestamps
  field :code
  field :song
  has_one :song
  has_one :idol
  has_one :user
end