class CronTasksController < ApplicationController
	layout 'admin'

	before_action :require_admin

	helper :sort
  include SortHelper

  def index
    sort_init 'id', 'asc'
    sort_update %w(id task last_run last_status interval enabled)
    @cron_tasks = CronTask.order(sort_clause)
  end

end