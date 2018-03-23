class MicroPost < ApplicationRecord
  belongs_to :user
  has_many :comments, class_name: 'Comment', foreign_key: 'micro_post_id', dependent: :destroy
end
