module ApplicationHelper

  def get_strftime intime
    # 将数据库中的UTC时间转换为本地时间
    return intime.utc.in_time_zone('Beijing').strftime(format='%F %T')
  end


end
