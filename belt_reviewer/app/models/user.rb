class User < ActiveRecord::Base
  has_secure_password
  email_regex = /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]+)\z/i
  validates :email, presence: true, format: { with: email_regex }, uniqueness: { case_sensitive: false }
  validates :first, :last, :city, presence: true

  has_many :events, dependent: :destroy
  has_many :events_attended, through: :attends, source: :event
  has_many :comments, dependent: :destroy
  has_many :attends, dependent: :destroy
end
