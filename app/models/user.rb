class User < ApplicationRecord
  before_save :default_values

  def default_values
    if self.picurl.nil?
      self.picurl = 'images/avatars/default/avatar.png'
    end
  end

  has_many :send_messages, class_name: 'Message', foreign_key: 'send_user', dependent: :destroy
  has_many :recieve_messages, class_name: 'Message', foreign_key: 'recieve_user', dependent: :destroy
  has_many :micro_posts, dependent: :destroy
  has_many :comments, class_name: 'Comment', foreign_key: 'user_id', dependent: :destroy

  VALID_EMAIL_REGEX = /\A[\w+\-.]+@([a-z\d\-]+\.)+[a-z]+\z/i
  before_save { self.email = email.downcase }
  validates :name, presence: true, length: {maximum: 50}, uniqueness: {
      case_sensitive: false
  }
  validates :email, presence: true, length: {maximum: 255},
            format: {with: VALID_EMAIL_REGEX}, uniqueness: {
          case_sensitive: true
      }
  has_secure_password
  validates :password, presence: true, length: {minimum: 6}, allow_nil: true



end
