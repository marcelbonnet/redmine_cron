module CronTasksHelper

	def toggle_enabled(task)
		link_to '', toggle_cron_tasks_path(task), remote:true, method: :put, class: "icon #{task.enabled ? 'icon-switch-on':'icon-switch-off'}"  
	end

	def show_task_status(task)
		return '-' if task.last_run <= DateTime.parse('1970-01-01')
		return l('redmine_cron.status_ok') if task.last_status == CronTask::STATUS_OK
		return l('redmine_cron.status_failed') if task.last_status == CronTask::STATUS_FAILED
	end

	def format_last_run(datetime)
		if datetime <= DateTime.parse('1970-01-01')
			return l('redmine_cron.never_executed')
		else
			return format_time datetime
		end
	end

end