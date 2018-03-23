class ChatController < ApplicationController
  before_action :logged_in_user

  include ChatHelper

  def index
    @user = current_user
    @current_chat_user_name = params[:chat_with]
    @chat_with_users = get_chat_with_users(@user)
    if !@current_chat_user_name.nil?
      @current_chat_user = User.find_by(name: @current_chat_user_name)
      if !@current_chat_user_name.nil?
        messages = process_messages(@user, @current_chat_user)
        render json: messages
      end
    end
  end

  def new
    # 用户发送新的消息

    @user = current_user
    username = @user.name
    userpic = @user.picurl

    msg = params[:msg]
    current_chat_user_name = params[:chat_with]
    current_chat_user = User.find_by(name: current_chat_user_name)
    save_time = DateTime.now
    msg_db = Message.new(content: msg, send_user: @user.id, recieve_user: current_chat_user.id,
                         create_time: save_time, readed: false)

    if msg_db.save
      render json: {username: username, userpic: userpic, content: msg, time: get_strftime(save_time)}
    else
      render json: {username: username, userpic: userpic, content: "error", time: get_strftime(save_time)}
    end

  end

  def notify
    # 获取未读短信数
    @user = current_user
    render json: {unreaded: unread_msg_num(@user)}
  end


  def online
    # # 获取未读短信和对对应的联系人
    @user = current_user
    results = unread_msg_users(@user)
    if results.empty?
      results = nil
    end
    render json: {users: results}
  end

  def query
    # 添加新的联系人
    @user = current_user
    query_name = params[:username]
    all_user_names = params[:all]
    query_pic = String.new()

    if all_user_names.nil?
      query_user = User.find_by(name: query_name)
      if query_user.nil?
        query_name = nil
        ok = false
      else
        if query_name == @user.name
          query_name = nil
          ok = false
        else
          query_name = query_user.name
          query_pic = query_user.picurl
          ok = true
        end
      end
    else
      if all_user_names.include? query_name or query_name == @user.name
        query_name = nil
        ok = false
      else
        query_user = User.find_by(name: query_name)
        if query_user.nil?
          query_name = nil
          ok = false
        else
          query_name = query_user.name
          query_pic = query_user.picurl
          ok = true
        end
      end
    end

    render json: {username: query_name, userpic: query_pic, ok: ok}
  end

end
