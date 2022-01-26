class CronTasksController < ApplicationController
	layout 'admin'

	before_action :require_admin
	before_action :find_cron_task, only: [:toggle, :show, :edit, :update, :destroy]

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

  def bulk_edit
  	params.require(:cron_task)
  	if params[:cron_task][:enabled].to_i == 1
  		CronTask.update_all enabled: true
  	else
  		CronTask.update_all enabled: false
  	end

  	redirect_to cron_tasks_path

  end

  def show
  end

  def new
  	@cron_task = CronTask.new
  end

  def create
  	params.require(:cron_task)
  	@cron_task = CronTask.new user: User.current
  	@cron_task.safe_attributes = params[:cron_task] if Rails::VERSION::MAJOR >= 5
    @cron_task.safe_attributes = params[:cron_task].permit(:task, :interval, :comments, :enabled) if Rails::VERSION::MAJOR == 4

  	if @cron_task.save
  		flash[:notice] = l(:notice_successful_create)
  		redirect_to cron_tasks_path(@cron_task.id)
  	else
  		render :action => 'new'
  	end
  end

  def edit

  end

  def update
    @cron_task.safe_attributes = params[:cron_task] if Rails::VERSION::MAJOR >= 5
    @cron_task.safe_attributes = params[:cron_task].permit(:task, :interval, :comments, :enabled) if Rails::VERSION::MAJOR == 4

  	if @cron_task.save
  		flash[:notice] = l(:notice_successful_update)
  		redirect_to cron_tasks_path(@cron_task.id)
  	else
  		render :action => 'edit'
  	end
  end

  def destroy
  	@cron_task.destroy
  	redirect_to cron_tasks_path
  end


  private

  def find_cron_task
  	@cron_task = CronTask.find(params['id'])
  end

end