require 'rss/parser'
require 'hpricot'
require 'cgi'

class SubredditRss
  attr_reader :url

  def initialize(url)
    @url = url
  end

  def feed
    rss = Feedjira::Feed.fetch_and_parse url
    rss.entries.each do |item|
      # Rewrite url to be the story url
      item.url   = story_url(item)
      item.image = story_image(item) if item.url
    end
    rss
  end

  private
  def story_image(item)
    terms = TermExtract.extract(item.title).to_a.flatten
    suckr = ImageSuckr::GoogleSuckr.new
    suckr.get_image_url({"q" => terms[0], "as_rights" => "(cc_publicdomain|cc_attribute|cc_sharealike)"})
  end

  def story_url(item)
    link = {}
    doc  = Hpricot(item.summary)

    non_reddit_links = doc.search("a").reject{ |a| a.attributes['href'] =~ /reddit/}
    link = non_reddit_links.find{ |a| a.attributes['href'] =~ /http/} || {} if non_reddit_links

    link['href']
  end
end