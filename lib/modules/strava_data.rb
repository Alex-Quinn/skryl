class StravaData < DataModule
  def update
    strava_client = Strava::Api::V3::Client.new(:access_token => config.token)
    strava_client.list_athlete_activities.each do |activity|
      activity = Activity.new_from_api_helper(activity)
      save_and_increment(activity) unless Activity.find_by_activity_id(activity.activity_id)
    end

    puts "Fetched #{counter} new activity(s)"
  end
end
