require 'spec_helper'

describe StravaData do
  describe "update" do
    it "saves all the activities in the database" do
      allow_any_instance_of(Strava::Api::V3::Client).to receive(:list_athlete_activities).and_return([
        {
          "id"=>12345,
          "resource_state"=>2,
          "external_id"=>nil,
          "upload_id"=>nil,
          "athlete"=>{
            "id"=>7740165,
            "resource_state"=>1
          },
          "name"=>"Commute",
          "distance"=>8851.4,
          "moving_time"=>1800,
          "elapsed_time"=>1800,
          "total_elevation_gain"=>0.0,
          "type"=>"Ride",
          "start_date"=>"2015-01-30T13:30:00Z",
          "start_date_local"=>"2015-01-30T07:30:00Z",
          "timezone"=>"(GMT-06:00) America/Chicago",
          "start_latlng"=>nil,
          "end_latlng"=>nil,
          "location_city"=>nil,
          "location_state"=>nil,
          "location_country"=>"United States",
          "start_latitude"=>nil,
          "start_longitude"=>nil,
          "achievement_count"=>0,
          "kudos_count"=>0,
          "comment_count"=>0,
          "athlete_count"=>1,
          "photo_count"=>0,
          "map"=>{
            "id"=>"a249160725",
            "summary_polyline"=>nil,
            "resource_state"=>2
          },
          "trainer"=>false,
          "commute"=>true,
          "manual"=>true,
          "private"=>false,
          "flagged"=>false,
          "gear_id"=>nil,
          "average_speed"=>4.917,
          "max_speed"=>0.0,
          "device_watts"=>false,
          "truncated"=>nil,
          "has_kudoed"=>false
        },
        {
          "id"=>54321,
          "resource_state"=>2,
          "external_id"=>nil,
          "upload_id"=>nil,
          "athlete"=>{
            "id"=>7740165,
            "resource_state"=>1
          },
          "name"=>"Training Ride",
          "distance"=>10000.4,
          "moving_time"=>6000,
          "elapsed_time"=>6000,
          "total_elevation_gain"=>0.0,
          "type"=>"Ride",
          "start_date"=>"2015-01-21T14:30:00Z",
          "start_date_local"=>"2015-01-21T08:30:00Z",
          "timezone"=>"(GMT-06:00) America/Chicago",
          "start_latlng"=>nil,
          "end_latlng"=>nil,
          "location_city"=>nil,
          "location_state"=>nil,
          "location_country"=>"United States",
          "start_latitude"=>nil,
          "start_longitude"=>nil,
          "achievement_count"=>0,
          "kudos_count"=>0,
          "comment_count"=>0,
          "athlete_count"=>1,
          "photo_count"=>0,
          "map"=>{
            "id"=>"a249160725",
            "summary_polyline"=>nil,
            "resource_state"=>2
          },
          "trainer"=>false,
          "commute"=>false,
          "manual"=>true,
          "private"=>false,
          "flagged"=>false,
          "gear_id"=>nil,
          "average_speed"=>4.917,
          "max_speed"=>0.0,
          "device_watts"=>false,
          "truncated"=>nil,
          "has_kudoed"=>false
        },
      ])

      expect do
        StravaData.update
      end.to change{ Activity.count }.by(2)

      first_activity = Activity.where(:activity_id => 12345).first!
      expect(first_activity).to_not be_nil
      expect(first_activity.activity_type).to eql("Ride")
      expect(first_activity.start_time).to eql(Time.new(2015,1,30,07,30,00).in_time_zone("America/Chicago"))
      expect(first_activity.status).to eql("2")
      expect(first_activity.duration).to eql(1800.0)
      expect(first_activity.distance).to eql(8851.4)
      expect(first_activity.gps_data).to be_nil
      expect(first_activity.speed_data).to be_nil
      expect(first_activity.commute).to eql(true)

      second_activity = Activity.where(:activity_id => 54321).first!
      expect(second_activity).to_not be_nil
      expect(second_activity.activity_type).to eql("Ride")
      expect(second_activity.start_time).to eql(Time.new(2015,1,21,8,30,00).in_time_zone("America/Chicago"))
      expect(second_activity.status).to eql("2")
      expect(second_activity.duration).to eql(6000.0)
      expect(second_activity.distance).to eql(10000.4)
      expect(second_activity.gps_data).to be_nil
      expect(second_activity.speed_data).to be_nil
      expect(second_activity.commute).to eql(false)
    end

    it "does not save a activity more than once" do
      allow_any_instance_of(Strava::Api::V3::Client).to receive(:list_athlete_activities).and_return([
        {
          "id"=>12345,
          "resource_state"=>2,
          "external_id"=>nil,
          "upload_id"=>nil,
          "athlete"=>{
            "id"=>7740165,
            "resource_state"=>1
          },
          "name"=>"Commute",
          "distance"=>8851.4,
          "moving_time"=>1800,
          "elapsed_time"=>1800,
          "total_elevation_gain"=>0.0,
          "type"=>"Ride",
          "start_date"=>"2015-01-30T13:30:00Z",
          "start_date_local"=>"2015-01-30T07:30:00Z",
          "timezone"=>"(GMT-06:00) America/Chicago",
          "start_latlng"=>nil,
          "end_latlng"=>nil,
          "location_city"=>nil,
          "location_state"=>nil,
          "location_country"=>"United States",
          "start_latitude"=>nil,
          "start_longitude"=>nil,
          "achievement_count"=>0,
          "kudos_count"=>0,
          "comment_count"=>0,
          "athlete_count"=>1,
          "photo_count"=>0,
          "map"=>{
            "id"=>"a249160725",
            "summary_polyline"=>nil,
            "resource_state"=>2
          },
          "trainer"=>false,
          "commute"=>true,
          "manual"=>true,
          "private"=>false,
          "flagged"=>false,
          "gear_id"=>nil,
          "average_speed"=>4.917,
          "max_speed"=>0.0,
          "device_watts"=>false,
          "truncated"=>nil,
          "has_kudoed"=>false
        },
        {
          "id"=>12345,
          "resource_state"=>2,
          "external_id"=>nil,
          "upload_id"=>nil,
          "athlete"=>{
            "id"=>7740165,
            "resource_state"=>1
          },
          "name"=>"Training Ride",
          "distance"=>10000.4,
          "moving_time"=>6000,
          "elapsed_time"=>6000,
          "total_elevation_gain"=>0.0,
          "type"=>"Ride",
          "start_date"=>"2015-01-21T14:30:00Z",
          "start_date_local"=>"2015-01-21T08:30:00Z",
          "timezone"=>"(GMT-06:00) America/Chicago",
          "start_latlng"=>nil,
          "end_latlng"=>nil,
          "location_city"=>nil,
          "location_state"=>nil,
          "location_country"=>"United States",
          "start_latitude"=>nil,
          "start_longitude"=>nil,
          "achievement_count"=>0,
          "kudos_count"=>0,
          "comment_count"=>0,
          "athlete_count"=>1,
          "photo_count"=>0,
          "map"=>{
            "id"=>"a249160725",
            "summary_polyline"=>nil,
            "resource_state"=>2
          },
          "trainer"=>false,
          "commute"=>false,
          "manual"=>true,
          "private"=>false,
          "flagged"=>false,
          "gear_id"=>nil,
          "average_speed"=>4.917,
          "max_speed"=>0.0,
          "device_watts"=>false,
          "truncated"=>nil,
          "has_kudoed"=>false
        },
      ])

      expect do
        StravaData.update
      end.to change{ Activity.count }.by(1)
    end
  end
end
