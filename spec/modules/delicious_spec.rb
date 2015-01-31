require 'spec_helper'

describe Delicious do
  describe "update" do
    it "saves all the links in the database" do
      allow_any_instance_of(WWW::Delicious).to receive(:posts_all).and_return([
        OpenStruct.new(
          :title => "First link",
          :url => URI("www.google.com"),
          :time => Time.new(2014,12,05,8,00,00),
          :tags => ["tag1", "tag2"],
        ),
        OpenStruct.new(
          :title => "Second link",
          :url => URI("www.yahoo.com"),
          :time => Time.new(2014,12,29,8,00,00),
          :tags => ["tag3", "tag4"],
        ),
      ])

      expect do
        Delicious.update
      end.to change{ Link.count }.by(2)

      first_link = Link.where(:title => "First link").first!
      expect(first_link).to_not be_nil
      expect(first_link.permalink).to eql("www.google.com")
      expect(first_link.tag).to eql("tag1,tag2")
      expect(first_link.published_at).to eql(Time.new(2014,12,05,8,00,00))

      second_link = Link.where(:title => "Second link").first!
      expect(second_link).to_not be_nil
      expect(second_link.permalink).to eql("www.yahoo.com")
      expect(second_link.tag).to eql("tag3,tag4")
      expect(second_link.published_at).to eql(Time.new(2014,12,29,8,00,00))
    end

    it "does not save a link more than once" do
      allow_any_instance_of(WWW::Delicious).to receive(:posts_all).and_return([
        OpenStruct.new(
          :title => "First link",
          :url => URI("www.google.com"),
          :time => Time.new(2014,12,05,8,00,00),
          :tags => ["tag1", "tag2"],
        ),
        OpenStruct.new(
          :title => "Second link",
          :url => URI("www.google.com"),
          :time => Time.new(2014,12,29,8,00,00),
          :tags => ["tag3", "tag4"],
        ),
      ])

      expect do
        Delicious.update
      end.to change{ Link.count }.by(1)
    end
  end
end
