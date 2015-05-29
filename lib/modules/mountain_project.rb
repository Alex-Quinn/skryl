class MountainProject < DataModule
  include RssHelper

  def update
    rss_for(config.rss_uri) do |item|
      parsed_item = _parse_tick_list_rss_item(item)
      climbing_route = ClimbingRoute.new_from_rss_helper(parsed_item)

      unless ClimbingRoute.find_by_link(climbing_route.link)
        save_and_increment(climbing_route)
      end
    end

    puts "Fetched #{counter} new climbing routes(s)"
  end

  def _parse_tick_list_rss_item(item)
    OpenStruct.new(
      :link => item.link,
      :name => _title_from_rss_title(item.title),
      :grade => _grade_from_rss_title(item.title),
      :location => _location_from_rss_description(item.description),
    )
  end

  def _title_from_rss_title(rss_title)
    /Route: ([A-Za-z0-9\-' ]+) \(<span/.match(rss_title).captures.first
  end

  def _grade_from_rss_title(rss_title)
    /class=\'rateYDS\'>([A-Za-z1-9.+]+)<\/span/.match(rss_title).captures.first
  end

  def _location_from_rss_description(rss_description)
    location_string = /Location: (.+)$/.match(rss_description).captures.first
    matches = location_string.scan(/\">([A-Za-z0-9 \-]+)<\/a>/)
    matches.reverse.map(&:first)[-2..-1].join(", ")
  end
end
