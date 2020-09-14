# == Schema Information
#
# Table name: users
#
#  id                     :bigint           not null, primary key
#  admin                  :boolean          default(FALSE)
#  email                  :string           default(""), not null, indexed
#  encrypted_password     :string           default(""), not null
#  first_name             :string
#  last_name              :string
#  remember_created_at    :datetime
#  reset_password_sent_at :datetime
#  reset_password_token   :string           indexed
#  created_at             :datetime         not null
#  updated_at             :datetime         not null
#
# Indexes
#
#  index_users_on_email                 (email) UNIQUE
#  index_users_on_reset_password_token  (reset_password_token) UNIQUE
#
class User < ApplicationRecord
  has_person_name
  before_save :downcase_email
  # before_create :set_username
  # after_create :assign_default_role
  

  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  
  # association 
  has_person_name
  has_one_attached :avatar

# validation
  validates           :first_name, presence:   true 
  validates           :last_name, presence:   true 
  validates_format_of :email,:with => Devise::email_regexp
  validates           :email, presence:   true, 
                              length:     { maximum: 50 },
                              uniqueness: { case_sensitive: false }
  
  # def assign_default_role
  #   add_role(:client)
  # end
  
  def full_name
    "#{first_name} #{last_name}"
  end

  # def set_username
  #   self.username = "#{first_name.downcase.titleize} #{last_name.downcase.titleize}".strip
  # end

	# def admin?
	# 	has_role?(:admin)
	# end

  # def client?
	# 	has_role?(:client)
  # end

  # Converts email to all lower-case.
  def downcase_email
    self.email = email.downcase
  end  

  
end
