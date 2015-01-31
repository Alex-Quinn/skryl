class Link < ActiveRecord::Base
  scope :ordered, order('published_at DESC')

  validates_presence_of   :title, :permalink, :published_at
  validates_uniqueness_of :permalink

  def self.new_from_api_helper(item)
    new :permalink => item.url.to_s,
        :title => item.title,
        :published_at => item.time,
        :tag => item.tags.join(',')
  end
end
