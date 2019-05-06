require 'rss/parser'
require 'hpricot'
require 'cgi'

class SubredditRss
  include Loggable
  
  attr_reader :url

  def initialize(url)
    @url = url
  end

  def feed
    rss = Feedjira::Feed.fetch_and_parse url
    rss.entries.each do |item|
      # Rewrite url to be the story url
      item.url   = story_url(item)
      item.image = story_image(item) if item.url.present?
    end

    rss.entries = rss.entries.find_all{|e| e.url.present?}

    rss
  end

  private
  
  def story_image(item)
    terms = TermExtract.extract(item.title).to_a.flatten
    suckr = ImageSuckr::GoogleSuckr.new
    suckr.get_image_url({"q" => terms[0], "as_rights" => "(cc_publicdomain|cc_attribute|cc_sharealike)"})
  end

  def story_url(item)
    return nil if item.try!(:content).blank?

    doc  = Hpricot(item.content)

    non_reddit_links = doc.search('a').reject{ |a| a.attributes['href'] =~ /(reddit|\/r\/)/i}
    link = non_reddit_links.find{ |a| a.attributes['href'] =~ /http/}

    return nil if link.nil?

    link['href']
  end
end