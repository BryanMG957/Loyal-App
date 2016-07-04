class ServiceType < ActiveRecord::Base
  has_many :appointments
  belongs_to :company
end
