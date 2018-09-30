class AdminUser < ApplicationRecord

  has_and_belongs_to_many :pages
  has_many :section_edits
  # Added rich associations. Relationship "has_many through" lets us use connection like
  # "admin_user.sections"
  has_many :sections, :through => :section_edits

end
