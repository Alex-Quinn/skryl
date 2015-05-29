require 'spec_helper'

describe MountainProject do
  describe "update" do
    it "saves all the ticks in the database" do
      allow_any_instance_of(RSS::Parser).to receive(:parse).and_return(
        OpenStruct.new(
          :items => [
            OpenStruct.new(
              :description => "An easy 5.7 by Seneca standards. Greenwall is in the shade for a lage portion of the day, and fairly protected fom the wind. <br /> <br />1st Pitch <br />Go up a short corner system. There are three cracks. The one is too big for most gear. Climb the middle one. Probably the crux of the route. Traverse across the large ledge and belay as close to the corner as you can. Trees and larger gear (#3). <br /> <br />2nd Pitch <br />Climb the corner and left facing face thru the intimidating looking bulge.  <br /> <br />3rd Pitch <br />Forth class scramble onto the proper summit <br /><br /><img width='369' height='555' src='http://www.mountainproject.com/images/37/42/105963742_medium_f4747c.jpg' alt=&quot;2ndbelay&quot; /><br/>Submitted By: <a href='http://www.mountainproject.com/u/brian-adzima//105855362'>Brian Adzima</a><br/>Location: <a target=\"_top\" href=\"http://www.mountainproject.com/v/west-virginia/105855459\">WV</a> : <a target=\"_top\" href=\"http://www.mountainproject.com/v/seneca-rocks/105861910\">Seneca Rocks</a> : <a target=\"_top\" href=\"http://www.mountainproject.com/v/south-peak---west-face/105861915\">South Peak - West Face</a><br/>",
              :link => "http://www.mountainproject.com/v/green-wall/105917255",
              :title => "Route: Green Wall (<span class='rateYDS'>5.7</span> <span class='rateFrench'>5a</span> <span class='rateEwbanks'>15</span> <span class='rateUIAA'>V+</span> <span class='rateZA'>13</span> <span class='rateBritish'>MVS 4b</span>)",
            ),
            OpenStruct.new(
              :description => "The obvious handcrack that heads strait up the Fantasy roof area. <br /> <br />Head up hand crack to ledge just under roof to the chain anchors. <br /> <br />Double rope setup would be nice on this route. <br /><br /><img width='416' height='555' src='http://www.mountainproject.com/images/35/50/106243550_medium_5a432e.jpg' alt=&quot;Hutch begins jamming up Fantasy Crack.&quot; /><br/>Submitted By: <a href='http://www.mountainproject.com/u/chris-hillios//106106734'>Chris Hillios</a><br/>Location: <a target=\"_top\" href=\"http://www.mountainproject.com/v/west-virginia/105855459\">WV</a> : <a target=\"_top\" href=\"http://www.mountainproject.com/v/the-new-river-gorge/105855991\">The New River Gorge</a> : <a target=\"_top\" href=\"http://www.mountainproject.com/v/new-river-gorge-proper/106040788\">New River Gorge Proper</a> : <a target=\"_top\" href=\"http://www.mountainproject.com/v/endless-wall/105943886\">Endless Wall</a> : <a target=\"_top\" href=\"http://www.mountainproject.com/v/fantasy-area/105970428\">Fantasy Area</a><br/>",
              :link => "http://www.mountainproject.com/v/fantasy/106155521",
              :title => "Route: Fantasy (<span class='rateYDS'>5.8</span> <span class='rateFrench'>5b</span> <span class='rateEwbanks'>16</span> <span class='rateUIAA'>VI-</span> <span class='rateZA'>15</span> <span class='rateBritish'>HVS 4c</span>)",
            )
          ]
        )
      )

      expect do
        MountainProject.update
      end.to change{ ClimbingRoute.count }.by(2)

      first_route = ClimbingRoute.where(:link => "http://www.mountainproject.com/v/green-wall/105917255").first!
      expect(first_route).to_not be_nil
      expect(first_route.name).to eql("Green Wall")
      expect(first_route.grade).to eql("5.7")
      second_route = ClimbingRoute.where(:link => "http://www.mountainproject.com/v/fantasy/106155521").first!
      expect(second_route).to_not be_nil
      expect(second_route.name).to eql("Fantasy")
      expect(second_route.grade).to eql("5.8")
    end
  end

  describe "_parse_tick_list_rss_item" do
    it "creates parses all the climbing route fields" do
      fake_route = OpenStruct.new(
        :description => "An easy 5.7 by Seneca standards. Greenwall is in the shade for a lage portion of the day, and fairly protected fom the wind. <br /> <br />1st Pitch <br />Go up a short corner system. There are three cracks. The one is too big for most gear. Climb the middle one. Probably the crux of the route. Traverse across the large ledge and belay as close to the corner as you can. Trees and larger gear (#3). <br /> <br />2nd Pitch <br />Climb the corner and left facing face thru the intimidating looking bulge.  <br /> <br />3rd Pitch <br />Forth class scramble onto the proper summit <br /><br /><img width='369' height='555' src='http://www.mountainproject.com/images/37/42/105963742_medium_f4747c.jpg' alt=&quot;2ndbelay&quot; /><br/>Submitted By: <a href='http://www.mountainproject.com/u/brian-adzima//105855362'>Brian Adzima</a><br/>Location: <a target=\"_top\" href=\"http://www.mountainproject.com/v/west-virginia/105855459\">WV</a> : <a target=\"_top\" href=\"http://www.mountainproject.com/v/seneca-rocks/105861910\">Seneca Rocks</a> : <a target=\"_top\" href=\"http://www.mountainproject.com/v/south-peak---west-face/105861915\">South Peak - West Face</a><br/>",
        :link => "http://www.mountainproject.com/v/green-wall/105917255",
        :title => "Route: Green Wall (<span class='rateYDS'>5.7</span> <span class='rateFrench'>5a</span> <span class='rateEwbanks'>15</span> <span class='rateUIAA'>V+</span> <span class='rateZA'>13</span> <span class='rateBritish'>MVS 4b</span>)",
      )

     parsed_route = MountainProject.new._parse_tick_list_rss_item(fake_route)

     expect(parsed_route.name).to eq("Green Wall")
     expect(parsed_route.grade).to eq("5.7")
     expect(parsed_route.link).to eq("http://www.mountainproject.com/v/green-wall/105917255")
     expect(parsed_route.location).to eq("Seneca Rocks, WV")
    end
  end
end
