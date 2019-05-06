class Rss < ActiveRecord::Base
  extend Loggable

  delegate :feed, to: :rss_klass

  FEEDS = [
      {
          name: "Reddit Psychology",
          description: "psychology",
          uid: "psychology",
          url: "https://www.reddit.com/r/psychology.rss",
          rss_type: "SubredditRss"
      },
      {
          name: "Reddit Productivity",
          description: "productivity",
          uid: "productivity",
          url: "https://www.reddit.com/r/productivity.rss",
          rss_type: "SubredditRss"
      },
      {
          name: "Reddit Business",
          description: "business",
          uid: "business",
          url: "https://www.reddit.com/r/business.rss",
          rss_type: "SubredditRss"
      },
      {
          name: "Reddit Economics",
          description: "economics",
          uid: "economics",
          url: "https://www.reddit.com/r/Economics.rss",
          rss_type: "SubredditRss"
      },
      {
          name: "Rails",
          description: "rails",
          uid: "rails",
          url: "https://www.reddit.com/r/rails.rss",
          rss_type: "SubredditRss"
      },
      {
          name: "Ruby on Rails",
          description: "ruby on rails",
          uid: "rubyonrails",
          url: "https://www.reddit.com/r/rubyonrails.rss",
          rss_type: "SubredditRss"
      },
      {
          name: "Agile",
          description: "agile",
          uid: "agile",
          url: "https://www.reddit.com/r/agile.rss",
          rss_type: "SubredditRss"
      },
      {
          name: "Programming",
          description: "programming",
          uid: "programming",
          url: "https://www.reddit.com/r/programming.rss",
          rss_type: "SubredditRss"
      }
  ]

  def self.seed
    logx "Creating feeds.."
    
    FEEDS.each do |feed|
      Rss.find_or_create_by!(uid: feed[:uid]) do |rss|
        rss.name        = feed[:name]
        rss.url         = feed[:url]
        rss.description = feed[:description]
        rss.rss_type    = feed[:rss_type]
      end
    end
  end

  private

  def rss_klass
    @rss_klass ||= rss_type.constantize.new(url)
  end
end
