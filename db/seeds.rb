# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)
Rss.create!(name: "Reddit Psychology", description: "psychology", uid: "psychology", url: "https://www.reddit.com/r/psychology.rss")
Rss.create!(name: "Reddit Productivity", description: "productivity", uid: "productivity", url: "https://www.reddit.com/r/productivity.rss")
Rss.create!(name: "Reddit Business", description: "business", uid: "business", url: "https://www.reddit.com/r/business.rss")
Rss.create!(name: "Reddit Economics", description: "economics", uid: "economics", url: "https://www.reddit.com/r/Economics.rss")