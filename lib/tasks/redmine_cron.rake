namespace :redmine do

  desc "Start point for a cron job to invoke any other task." 
  task cron_job: :environment do

    include Redmine::I18n #https://stackoverflow.com/questions/17304110/is-it-possible-to-include-modules-in-rake-task-and-make-its-methods-available-fo
    set_language_if_valid(ENV['REDMINE_LANG'])

    CronTask.where("enabled = true and task != 'cron_job'").order(:id).each do |task|

      puts ""
      puts "="*80
      puts "#{l('redmine_cron.task_started')} ##{task.id} #{task.task} #{DateTime.now}"
      puts task.to_s.split('  ').join("\n").gsub(/^/,'  ')
      puts "  #{l('redmine_cron.runnable')} #{task.runnable?}"

      if !task.runnable?
        puts "  #{l('redmine_cron.skipped')}"
        next
      end

      begin
        Rake::Task[task.task].invoke
        puts "  #{l('redmine_cron.finished')}"
        task.update_attribute(:last_status, CronTask::STATUS_OK)
      rescue => e
        task.update_attribute(:last_status, CronTask::STATUS_FAILED)
        puts e.backtrace.split.join("\n").gsub(/^/,'  ')
      end

      task.update_attribute(:last_run, DateTime.now)
    end

  end

end