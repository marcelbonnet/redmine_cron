class CreateDemoTasks < ActiveRecord::Migration[4.2]
	
	def up

			CronTask.create task: "redmine:attachments:prune",
	 			enabled: false,
	 			interval: 24*60,
	 			user_id: User.where(admin:true).first.id,
	 			comments: "Removes uploaded files left unattached after one day" if CronTask.find_by(task:"redmine:attachments:prune").nil?

	 		CronTask.create task: "redmine:tokens:prune",
	 			enabled: false,
	 			interval: 24*60,
	 			user_id: User.where(admin:true).first.id,
	 			comments: "Removes expired tokens once a day"  if CronTask.find_by(task:"redmine:tokens:prune").nil?

	 		CronTask.create task: "redmine:watchers:prune",
	 			enabled: false,
	 			interval: 4*60,
	 			user_id: User.where(admin:true).first.id,
	 			comments: "Removes watchers from what they can no longer view"  if CronTask.find_by(task:"redmine:watchers:prune").nil?

	 		CronTask.create task: "redmine:send_reminders",
	 			enabled: false,
	 			interval: 48*60,
	 			user_id: User.where(admin:true).first.id,
	 			comments: "Send reminders about issues due in the next days. Runs every 48 hours. Need to run every friday afternoon? Create a rake task to invoke redmine:send_reminders with Rake::Task['redmine:send_reminders'].invoke "  if CronTask.find_by(task:"redmine:send_reminders").nil?

	end

end