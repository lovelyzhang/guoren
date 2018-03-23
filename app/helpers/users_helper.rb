module UsersHelper
  def get_user_name_from_id user_id
    user = User.find_by(id: user_id)
    return user.name if !user.nil?
  end

  def get_user_sexual user
    user.sexual
  end
end

