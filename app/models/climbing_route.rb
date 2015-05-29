class ClimbingRoute < ActiveRecord::Base
  scope :ordered,   order('completed_at DESC')

  validates_presence_of   :name, :grade, :link
  validates_uniqueness_of :link

  def self.new_from_rss_helper(item)
    new :name         => item.name,
        :grade        => item.grade,
        :location     => item.location,
        :link         => item.link,
        :completed_at => item.completed_at
  end
end
