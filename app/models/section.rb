class Section < ApplicationRecord

  acts_as_list :scope => :page

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

  # Ruby constant
  CONTENT_TYPES = ['Text', 'HTML']

  # Long style validations
  # validates_presence_of :name
  # validates_length_of :name, :maximum => 255
  # validates_inclusion_of :content_type, :in => CONTENT_TYPES,
  # :message => "Must be one of #{CONTENT_TYPES.join(', ')}"
  # validates_presence_of :content

  # "sexy validations"
  validates :name, :presence => true,
                   :length => {:maximum => 255 }
  validates :content_type, :inclusion => {:in => CONTENT_TYPES,
            :message => "Must be one of #{CONTENT_TYPES.join(', ')}" }
  validates :content, :presence => true

end
