class Client < ActiveRecord::Base
  belongs_to :company
  def to_s
  	return full_name
  end
  def full_name
  	return self.first_name.to_s + " " + self.last_name.to_s
  end
end
