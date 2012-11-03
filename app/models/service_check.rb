class ServiceCheck < ActiveRecord::Base
  attr_accessible :service, :up
  belongs_to :monitored_service
  validates :monitored_service, presence: true
end
