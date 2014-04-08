class Task
  include Mongoid::Document
  include Mongoid::Timestamps
  field :name
  #quantity, obtain, event
  field :type
  field :target_model
  field :target_field
  field :target_number
  field :target_object
  field :target_event

  belongs_to :idol
  def process
    #change event to trigger
  end
end