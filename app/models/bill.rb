class Bill < ActiveRecord::Base
  belongs_to :client
  has_many :appointments
  def appt_ids_to_bill
  end
end
