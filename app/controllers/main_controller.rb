class MainController < ApplicationController
  include MainHelper
  before_action :logged_in_user


  def show
    @user = current_user
    page_num = params[:page]
    post_type = params[:type]

    if !page_num
      page_num = 1
    end
    if !post_type
      post_type=[1, 2, 3]
    end

    @posts = MicroPost.where(post_type: post_type).paginate(:page => page_num, :per_page => 10).order(post_time: :desc)
    @micro_posts_array = get_post(@posts)
    render 'main'

  end

  def activity
    @user = current_user
    micro_post_id = params[:micropost_id]
    join = params[:join].to_s

    if join == "true"
      num, names = new_engaged_people(micro_post_id, current_user.name)
    else
      num, names = delete_engaged_people(micro_post_id, current_user.name)
    end

    render json: {total_num: num, total_names: names}
  end

end
