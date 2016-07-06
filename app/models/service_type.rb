class ServiceType < ActiveRecord::Base
  has_many :appointments
  belongs_to :company
  def to_s
    return self.billing_display_name
  end
end
