module MainHelper

  def get_post posts
    micro_posts_array = []
    if !posts.empty?
      posts.each do |micro_post|
        x = Hash.new()
        x["username"] = micro_post.user.name
        x["userpic"] = micro_post.user.picurl
        x["postid"] = micro_post.id
        x["title"] = micro_post.title
        x["content"] = micro_post.content
        case micro_post.post_type
          when 1
            x["type"] = "新鲜事"
          when 2
            x["type"] = "组团信息"
          when 3
            x["type"] = "失物招领"
          else
            x["type"] = "新鲜事"
        end
        x["time"] = get_strftime(micro_post.post_time)
        x["pics"] = micro_post.pic.split(',') if micro_post.pic
        x["peo_num"] = micro_post.engage_people
        micro_posts_array << x
      end
    end
    return micro_posts_array
  end

  def get_engaged_people micropost_id
    # 获得参加活动的人数和姓名
    MicroPost.transaction do
      micropost = MicroPost.lock.find_by(id: micropost_id)
      engage_people = micropost.engage_people
      engage_people_name = micropost.engaged_people_names
      return engage_people, engage_people_name
    end
  end

  def save_engaged_people(micropost_id, num, names)
    # 将参加活动的人数和姓名存入数据库中
    MicroPost.transaction do
      micropost = MicroPost.lock.find_by(id: micropost_id)
      micropost.engage_people = num
      micropost.engaged_people_names = names
      micropost.save
    end
  end

  def new_engaged_people(micropost_id, name)
    # 新参加活动登记
    engage_people, engage_people_names = get_engaged_people micropost_id
    if engage_people_names.nil?
      engage_people += 1
      engage_people_names = name
    else
      engage_people_names = engage_people_names.split(',')
      if engage_people_names.include?(name) != true
        engage_people_names << name
        engage_people += 1
      end
      engage_people_names = engage_people_names.join(',')
    end
    save_engaged_people(micropost_id, engage_people, engage_people_names)
    return engage_people, engage_people_names
  end

  def delete_engaged_people(micropost_id, name)
    # 退出活动登记
    engage_people, engage_people_names = get_engaged_people micropost_id
    engage_people_names = engage_people_names.split(',')
    if engage_people_names.delete(name)
      engage_people_names = engage_people_names.join(',')
      engage_people -= 1
      save_engaged_people(micropost_id, engage_people, engage_people_names)
    end
    return engage_people,engage_people_names
  end

  def joinded_activity(micropost_id,name)
    engage_people, engage_people_names = get_engaged_people micropost_id
    if engage_people_names.nil?
      return false
    end
    engage_people_names = engage_people_names.split(',')
    return engage_people_names.include?(name)
  end


  def micro_post_belong_to_user(micropost_id,user)
    find_result = user.micro_posts.where(id: micropost_id)
    return !find_result.empty?
  end

  end
