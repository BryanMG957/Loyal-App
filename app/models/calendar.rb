class Calendar < ActiveRecord::Base
  has_many :appointments
  belongs_to :company
  def to_s
  	name.to_s
  end
  # @types = [{ :value => "icloud", :display => "iCloud"},
  # 					{ :value => "google", :display => "outlook" }]
end
