class UsersController < ApplicationController

  before_action :logged_in_user,except: [:new,:create,:forgetpasswd,:changepasswd]
  @@user_pics_dir = "public/userpics"

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    if @user.save
      log_in @user
      redirect_to main_path
    else
      render 'new'
    end
  end

  def edit
    @user = current_user
    render 'edit'
  end


  def update
  end


  def forgetpasswd
    useremail = params[:email]
    if useremail
      @user = User.find_by(email: useremail)
      if !@user.nil?
        send_code @user
        flash[:success] = "验证码已发送至您的邮箱"
        redirect_to changepasswd_path(email: @user.email)
      else
        flash[:danger] = "用户不存在"
        render 'forgetpasswd'
      end
    else
      render 'forgetpasswd'
    end
  end

  def changepasswd
    if request.get?
      user_email = params[:email]
      if user_email
        @user = User.find_by(email: user_email)
        if !@user.nil?
          render 'changepasswd'
        else
          flash[:danger] = "用户不存在"
          redirect_to login_path
        end
      else
        redirect_to login_path
      end
    else
      result = check_change_params(params[:email], params[:verify_code], params[:password], params[:password_confirm])
      if result
        flash[:success]="密码更新成功"
      else
        flash[:danger]="密码更新失败"
      end
      redirect_to login_path
    end
  end

  def changeprofile
    @user = current_user
    result, user, err_string = check_change_profile_params(params[:user])
    if result == false
      flash[:danger] = err_string
    else
      pic_url = save_user_pic params[:user][:pic]
      if pic_url.nil? == false
        user[:picurl] = pic_url
      end
      @user.update_attributes(user)
    end
    redirect_to profile_path
  end

  private

  def user_params
    params.require(:user).permit(:name, :email, :password,
                                 :password_confirmation)
  end

  def check_change_profile_params user_params
    if user_params.nil?
      return false, nil, "修改参数为空"
    end
    if user_params[:username].length <= 0
      return false, nil, "姓名错误"
    end
    user = Hash.new
    user[:name] = user_params[:username]
    user[:profession] = user_params[:profession]
    user[:sexual] = user_params[:sexual]
    return true, user, nil
  end

  def save_user_pic pic
    if pic.nil?
      return nil
    end
    if !(File.directory? @@user_pics_dir)
      FileUtils.mkdir_p(@@user_pics_dir)
    end
    ext = File.extname(pic.original_filename)
    timestamp = Time.now.to_s
    picname = Digest::MD5::hexdigest(pic.original_filename + timestamp) + ext
    File.open(File.join(@@user_pics_dir, picname), 'wb') { |f| f.write(pic.read) }
    save_name = File.join("userpics", picname)
    return save_name
  end

  def send_code user
    verify_code = rand(999999).to_s
    result = UserMailer.send_verify_code(user.email, verify_code).deliver_now
    p result
    user.update_attribute(:verify_code, verify_code)
  end

  def check_change_params(email, verify_code, password, password_confirmation)
    if password != password_confirmation
      return false
    end
    user = User.find_by(email: email)
    if user.nil?
      return false
    end
    if user.verify_code != verify_code
      return false
    end
    hold = Hash.new
    hold[:password] = password
    hold[:password_confirmation] = password_confirmation
    user.update_attributes(hold)
    return true
  end

end
