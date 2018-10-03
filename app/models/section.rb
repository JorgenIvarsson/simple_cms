class Section < ApplicationRecord

  belongs_to :page
  has_many :section_edits
  # Added rich associations. Relationship "has_many through" lets us use connection like
  # "section.admin_users"
  has_many :admin_users, :through => :section_edits

  scope :visible, lambda { where(:visible => true) }
  scope :invisible, lambda { where(:visible => false) }
  scope :sorted, lambda { order("position ASC") }
  scope :newest_first, lambda { order("created_at DESC") }
  scope :search, lambda { |query| where(["name LIKE ?", "%#{query}%"]) }
end
