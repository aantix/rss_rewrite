json.array!(@rsses) do |rss|
  json.extract! rss, :id, :name, :uid, :url
  json.url rss_url(rss, format: :json)
end
