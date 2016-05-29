class Client < ActiveRecord::Base
  validates :first_name, :last_name, presence: true
  belongs_to :company
  has_many :pets
  def to_s
  	return full_name
  end
  def full_name
  	return self.first_name.to_s + " " + self.last_name.to_s
  end
  def petlist
  	self.pets.map { |pet| pet.name }
  end
  def dropdown_label
    if (petlist.length > 0)
      full_name + " - " + petlist.join(", ")
    else
      full_name
    end
  end
end
