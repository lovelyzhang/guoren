class CommentsController < ApplicationController
  include CommentsHelper

  def get
    micropost_id = params["micropost_id"]
    micropost_comments = get_micropost_comments micropost_id
    render json: {comments: micropost_comments}
  end

  def new
    @user = current_user
    username = @user.name
    userpic = @user.picurl
    content = params[:content].to_s
    micropost_id = params[:micropost_id]
    if !content.empty? and !micropost_id.nil?
      comments = @user.comments.new(content: content, micro_post_id: micropost_id, comment_time: DateTime.now)
      comments.save
    end
    render json: {username: username, userpic: userpic}
  end

end
