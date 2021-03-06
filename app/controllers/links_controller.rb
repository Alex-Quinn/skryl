class LinksController < ApplicationController
  caches_action :index, :cache_path => lambda { |c| c.params }

  def index
    @links = Link.ordered.all
    redirect_to :root unless @links.any?

    @links_count = @links.count
    @links_by_year = @links.group_by{|t| t.published_at.year }
    @link_count_by_year = @links.count_by{|a| a.published_at.beginning_of_year}

    gon.linkCountByYearCategories = [ @link_count_by_year.map{|k, v| k.strftime('%Y')}.map{ |d| "'#{d}'" }.join(', ') ]
    gon.linkCountByYearData       = [ @link_count_by_year.map{|k, v| v}.join(', ') ]
  end
end

