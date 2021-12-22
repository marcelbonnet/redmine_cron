class CronTask < ActiveRecord::Base
	belongs_to :user

	validates_presence_of :user

	STATUS_OK = 0
	STATUS_FAILED=1

	def self.enabled_tasks
		CronTask.where(enabled:true)
	end

	def runnable?
		enabled && ((DateTime.now > (last_run + interval.minutes)) || last_status == STATUS_FAILED)
	end

	def to_s
		"[##{id}]  task:#{task}  enabled:#{enabled}  last_run:#{last_run}  last_status:#{last_status}  interval:#{interval} minutes"
	end
end