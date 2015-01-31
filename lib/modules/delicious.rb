class Delicious < DataModule
  def update
    delicious_client = WWW::Delicious.new(config.user, config.password)
    delicious_client.posts_all.each do |post|
      link = Link.new_from_api_helper(post)
      save_and_increment(link) unless Link.find_by_permalink(link.permalink)
    end

    puts "Fetched #{counter} new link(s)"
  end
end
