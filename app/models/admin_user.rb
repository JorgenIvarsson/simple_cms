class AdminUser < ApplicationRecord

  has_secure_password

  has_and_belongs_to_many :pages
  has_many :section_edits
  # Added rich associations. Relationship "has_many through" lets us use connection like
  # "admin_user.sections"
  has_many :sections, :through => :section_edits

  scope :sorted, lambda { order("last_name ASC, first_name ASC") }


  EMAIL_REGEX = /\A[a-z0-9._%+-]+@[a-z0-9.-]+\.[a-z]{2,4}\Z/i
  # Long for validations
  # validates_presence_of :first_name
  # validates_length_of :first_name, :maximum => 25
  # validates_presence_of :last_name
  # validates_length_of :last_name, :maximum => 50
  # validates_presence_of :username
  # validates_length_of :username, :within => 8..25
  # validates_uniqueness_of :username
  # validates_presence_of :email
  # validates_length_of :email, :maximum => 100
  # validates_format_of :email, :with => EMAIL_REGEX
  # validates_confirmation_of :email

  # "sexy validations"
  validates :first_name, :presence => true,
                         :length => { :maximum => 25 }
  validates :last_name, :presence => true,
                        :length => { :maximum => 50 }
  validates :username, :presence => true,
                       :length => { :within => 8..25 },
                       :uniqueness => true
  validates :email, :presence => true,
                    :length => { :maximum => 100 },
                    :format => EMAIL_REGEX,
                    :confirmation => true

  # Class method for returning AdminUser full name
  def name
    [first_name, last_name].join(' ')
    # "#{first_name} {last_name}" also works.
  end

end
