class Calendar < ActiveRecord::Base
  has_many :employees

  # @types = [{ :value => "icloud", :display => "iCloud"},
  # 					{ :value => "google", :display => "outlook" }]
end
