class CronTasksController < ApplicationController
	layout 'admin'

	before_action :require_admin
	before_action :find_cron_task, only: [:toggle, :show]

	helper :sort
  include SortHelper

  def index
    sort_init 'id', 'asc'
    sort_update %w(id task last_run last_status interval enabled)
    @cron_tasks = CronTask.order(sort_clause)
  end

  def toggle
  	@cron_task.update_attribute(:enabled, !@cron_task.enabled)
  	respond_to :js
  end

  
  private

  def find_cron_task
  	@cron_task = CronTask.find(params['id'])
  end

end