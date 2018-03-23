module CommentsHelper
  def get_micropost_comments micropost_id
    comments_array = Array.new()
    micropost = MicroPost.find_by(id: micropost_id)
    comments = micropost.comments.order(comment_time: :desc)
    if !comments.empty?
      comments.each do |com|
        temp = Hash.new()
        temp["username"] = com.user.name
        temp["userpic"] = com.user.picurl
        temp["content"] = com.content
        comments_array << temp
      end
    end
    return comments_array
  end

end
