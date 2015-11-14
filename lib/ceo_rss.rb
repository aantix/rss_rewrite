require 'rss/parser'
require 'hpricot'
require 'cgi'
require 'open-uri'

class CeoRss
  attr_reader :url
  CeoItem = Struct.new(:title, :content, :published, :url, :entry_id, :image)

  def initialize(url)
    # @url = "http://www.ceo.com/most-popular/"
    @url = url
  end

  def feed
    story_urls.collect do |story|
      item = CeoItem.new
      item.title     = story.inner_html
      item.url       = story_url(story['href'])
      item.published = Time.now
      item.entry_id  = item.url
      item.image     = story_image(item)
      item
    end
  end

  private
  def doc
    open(url) {|f| Hpricot(f)}
  end

  def story_image(item)
    terms = TermExtract.extract(item.title).to_a.flatten
    suckr = ImageSuckr::GoogleSuckr.new
    suckr.get_image_url({"q" => terms[0], "as_rights" => "(cc_publicdomain|cc_attribute|cc_sharealike)"})
  end

  def story_url(original_url)
    original_url.gsub!('http://www.ceo.com/flink/?lnk=', '')
    original_url.gsub!(/\&amp;id=(\d*)/, '')

    URI.unescape original_url
  end

  def story_urls
    doc.search("a").select{ |a| a.attributes['href'] =~ /\/flink\//}
  end
end