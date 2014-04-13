class Photo
  include Mongoid::Document
  include Mongoid::Timestamps
  field :pic_url
  belongs_to :song
  
end