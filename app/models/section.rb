class Section < ApplicationRecord

  belongs_to :page
  has_many :section_edits
  # Added rich associations. Relationship "has_many through" lets us use connection like
  # "section.admin_users"
  has_many :admin_users, :through => :section_edits
end
