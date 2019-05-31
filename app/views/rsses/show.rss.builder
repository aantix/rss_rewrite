xml.instruct! :xml, :version => "1.0"
xml.rss "version" => "2.0", "xmlns:media" => "http://search.yahoo.com/mrss", "xmlns:atom"=>"http://www.w3.org/2005/Atom" do
  xml.channel do

    xml.title @rss.name
    xml.description @rss.description
    xml.link request.original_url

    @posts.entries.each do |post|
      next unless post.url
      xml.item do
        xml.title post.title
        xml.description post.content
        xml.pubDate post.published.to_s(:rfc822)
        xml.link post.url
        xml.guid post.entry_id
        xml.media :thumbnail, url: post.image
        xml.media :content, url: post.image
      end
    end
  end
end