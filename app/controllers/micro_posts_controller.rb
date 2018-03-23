class MicroPostsController < ApplicationController
  include MicroPostsHelper
  before_action :logged_in_user


  def show
    @user = current_user
    @micro_posts = read_each_post @user
  end

  def new
    @user = current_user

    post_type = params[:post_type].to_i
    title = params[:title].to_s
    content = params[:content].to_s
    pictures = params[:pictures]

    if pictures
      pic_path = Array.new
      pictures.each do |pic|
        savename = savePicture(pic)
        pic_path << savename
      end
      pic_path = pic_path.join(',')
    end

    if post_type >= 1 and post_type <= 3 and !title.empty? and !content.empty?
      micropost = @user.micro_posts.new(title: title, content: content, pic: pic_path,
                                        post_time: DateTime.now, post_type: post_type,
                                        engage_people: 1, engaged_people_names: current_user.name)
      micropost.save
    end
    redirect_to microposts_path
  end

  def delete
    @user = current_user
    micropost_id = params[:micropost_id].to_i
    micropost_id = @user.micro_posts.find_by(id: micropost_id)
    if micropost_id
      micropost_id.destroy
      render json: {status:true}
    else
      render json: {status:false}
    end
  end

end
