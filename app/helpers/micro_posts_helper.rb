module MicroPostsHelper

  require 'fileutils'
  @@micro_posts_dir = "public/data"

  def read_each_post user
    micro_posts_array = []
    micro_posts = user.micro_posts.all.order(post_time: :desc)
    if !micro_posts.empty?
      micro_posts.each do |micro_post|
        x = Hash.new()
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
        x["peo_names"] = micro_post.engaged_people_names
        x["comments"] = micro_post.comments
        micro_posts_array << x
      end
    end
    return micro_posts_array
  end

  def savePicture pic
    if !(File.directory? @@micro_posts_dir)
      FileUtils.mkdir_p(@@micro_posts_dir)
    end
    ext = File.extname(pic.original_filename)
    timestamp = Time.now.to_s
    save_name = Digest::MD5::hexdigest(pic.original_filename + timestamp) + ext
    File.open(File.join(@@micro_posts_dir, save_name), 'wb') { |f| f.write(pic.read) }
    return save_name
  end

end
