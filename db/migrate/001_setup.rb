class Setup < ActiveRecord::Migration[4.2]
	def change
		create_table :cron_tasks do |t|
			t.string :task, null: false
			t.datetime :last_run, default: '1970-01-01T00:00:00+00:00'
			t.integer :last_status, default: CronTask::STATUS_OK
			t.boolean :enabled, null: false
			t.integer :interval, null: false
			t.belongs_to :user, null: false
			t.timestamps
		end
	end
end