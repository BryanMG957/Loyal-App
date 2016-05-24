class Pet < ActiveRecord::Base
  belongs_to :client
  def to_s
  	return name
  end
end
