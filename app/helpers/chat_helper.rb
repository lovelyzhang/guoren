module ChatHelper


  def get_chat_with_users user
    # 获得与当前用户有聊天记录的用户
    chat_with_users = {}

    user.recieve_messages.where(readed: true).select(:send_user).distinct.each do |chat|
      temp_user_id = chat.send_user
      find_user = User.find(temp_user_id)
      user_name_sym = find_user.name.to_sym
      chat_with_users[user_name_sym] = true
    end

    user.send_messages.select(:recieve_user).distinct.each do |chat|
      temp_user_id = chat.recieve_user
      find_user = User.find(temp_user_id)
      user_name_sym = find_user.name.to_sym
      chat_with_users[user_name_sym] = true
    end

    user.recieve_messages.where(readed: false).select(:send_user).distinct.each do |chat|
      temp_user_id = chat.send_user
      find_user = User.find(temp_user_id)
      user_name_sym = find_user.name.to_sym
      chat_with_users[user_name_sym] = false
    end

    return chat_with_users

  end

  def process_messages(user, chat_with)
    # 处理用户对话（消息）
    results = []

    Message.transaction do
      messages = Message.lock.where(send_user: [user.id, chat_with.id],
                                    recieve_user: [user.id, chat_with.id])

      if messages.length >= 1
        messages = messages.order(create_time: :asc)
        messages.each do |message|
          if message.send_user == user.id
            x = {issend: true, name: user.name, userpic: user.picurl,
                 content: message.content, time: get_strftime(message.create_time)}
          else
            message.readed = true
            message.save
            x = {issend: false, name: chat_with.name, userpic: chat_with.picurl,
                 content: message.content, time: get_strftime(message.create_time)}
          end
          results << x
        end
      end
    end
    results
  end

  def unread_msg_num user
    # 未读消息数目
    user.recieve_messages.where(readed: false).count
  end

  def unread_msg_users user
    # 未读消息的用户
    return_user_msg = {}
    results = user.recieve_messages.where(readed: false)
    if results.length != 0
      results.each do |result|
        username = User.find(result.send_user).name
        return_user_msg[username] = [];
        return_user_msg[username] <<result.content;
      end
    end
    return_user_msg
  end
end
