class Event < ActiveRecord::Base
  belongs_to :user
  has_many :active_subscribes
end
