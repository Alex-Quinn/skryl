Rails.configuration.name         = Rails.application.class.parent.name
Rails.configuration.full_name    = 'Alex Quinn'
Rails.configuration.display_name = 'Alex Quinn'

Github.configure do |mod|
  mod.user = 'Alex-Quinn'
end

Goodreads.configure do |mod|
  mod.shelf   = 'read'
  mod.key     = ENV['GOODREADS_KEY']
  mod.user_id = ENV['GOODREADS_ID']
  mod.uri     = "http://www.goodreads.com/review/list/#{mod.user_id}.xml?v=2&per_page=200&shelf=read&sort=date_read&key=#{mod.key}"
end

Delicious.configure do |mod|
  mod.user = ENV['DELICIOUS_USER']
  mod.password = ENV['DELICIOUS_PASSWORD']
end

StravaData.configure do |mod|
  mod.token = ENV['STRAVA_TOKEN']
end

MountainProject.configure do |mod|
  mod.user_id = ENV['MOUNTAIN_PROJECT_USER_ID']
  mod.rss_uri = "http://www.mountainproject.com/scripts/RSS.php?type=userTicks&userId=#{mod.user_id}"
end
