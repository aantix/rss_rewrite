class UpdateRss
  include Loggable
  include SuckerPunch::Job

  workers 1

  def perform(rss_uid)
    logx "UpdateRss started #{rss_uid}"
    
    rss   = Rss.find_by(uid: rss_uid)
    return if rss.nil?

    Rails.cache.write("feed-#{rss_uid}", rss.feed)

    logx "UpdateRss finished #{rss_uid}"
  end
end