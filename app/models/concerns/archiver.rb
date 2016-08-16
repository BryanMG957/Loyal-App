module Archiver
  extend ActiveSupport::Concern

  included do
    scope :active, ->{ where.not(archived: true) }
    scope :inactive, ->{ where(archived: true) }
  end

  def archived?
    if has_attribute?(:archived)
      archived
    end
  end

  def archive
    if has_attribute?(:archived)
      update_attributes(archived: true)
    end
  end

  def unarchive
    if has_attribute?(:archived)
      update_attributes(archived: false)
    end
  end
end
