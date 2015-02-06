class HomeController < ApplicationController
  caches_action :index

  def index
    @actions                 = GithubAction.ordered.limit(10)
    @action_count_by_month   = GithubAction.past_year.order('published_at ASC').count_by {|a| a.published_at.beginning_of_month}
    @links                   = Link.ordered.limit(10)
    @book                    = Book.ordered.first
    @book_count_by_year      = Book.ordered.count_by{|b| b.finished_at.beginning_of_year}
    @commute_count           = Activity.commute.past_year.instances_by_week
    @training_count          = Activity.training.past_year.instances_by_week

    gon.bookCountByYearData          = @book_count_by_year.map{|k, v| v}
    gon.bookCountByYearCategories    = @book_count_by_year.map{|k, v| k.strftime('%Y')}

    gon.actionCountByMonthCategories = @action_count_by_month.map{|k, v| k.strftime("%b '%y")}
    gon.actionCountByMonthData       = @action_count_by_month.map{|k, v| v}
    gon.actionCountByMonthStep       = defined?(is_compact) && is_compact ? 2 : 1

    gon.commuteChartCategories      = @commute_count.map{|k, v| k.strftime("%b %d '%y")}
    gon.commuteChartData            = @commute_count.map{|k, v| v}

    gon.trainingChartCategories      = @training_count.map{|k, v| k.strftime("%b %d '%y")}
    gon.trainingChartData            = @training_count.map{|k, v| v}
  end
end
