class Page < ApplicationRecord

  belongs_to :subject
  has_many :sections
  has_and_belongs_to_many :admin_users

  scope :visible, lambda { where(:visible => true) }
  scope :invisible, lambda { where(:visible => false) }
  scope :sorted, lambda { order("position ASC") }
  scope :newest_first, lambda { order("created_at DESC") }
  scope :search, lambda { |query| where(["name LIKE ?", "%#{query}%"]) }

  validates_presence_of :name
  validates_lenght_of :name, :maximum => 255
  validates_lenght_of :permalink
  validates_lenght_of :permalink, :within => 3..255
  validates_uniqueness_of :permalink
  
end
