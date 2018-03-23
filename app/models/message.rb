class Message < ApplicationRecord
  belongs_to :sender, class_name: 'User', foreign_key: 'send_user'
  belongs_to :reciever, class_name: 'User', foreign_key: 'recieve_user'
end
