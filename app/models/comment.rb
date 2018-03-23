class Comment < ApplicationRecord
  belongs_to :user, class_name: 'User', foreign_key: 'user_id'
  belongs_to :micro_post, class_name: 'MicroPost', foreign_key: 'micro_post_id'
end