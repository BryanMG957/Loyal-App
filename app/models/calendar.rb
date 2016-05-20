class Calendar < ActiveRecord::Base
  has_many :employees
  def to_s
  	name.to_s
  end
  # @types = [{ :value => "icloud", :display => "iCloud"},
  # 					{ :value => "google", :display => "outlook" }]
end
