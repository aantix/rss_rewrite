class UpdateAllRss
  extend Loggable
  include Loggable
  include SuckerPunch::Job

  def perform
    Rss.all.each do |rss|
      logx "UpdateAllRss#perform :: #{rss.uid}"
      
      UpdateRss.perform_async(rss.uid)
    end

    UpdateAllRss.perform_in(60.minutes.to_i)
  end

  def self.warm_cache
    return if $0 =~ /rake$/
    
    logx "Starting... "
    
    UpdateAllRss.perform_async
  end
end