namespace :redmine do

  desc "Start point for a cron job to invoke any other task." 
  task cron_job: :environment do

    # args.with_defaults(:lang => 'en')
    include Redmine::I18n #https://stackoverflow.com/questions/17304110/is-it-possible-to-include-modules-in-rake-task-and-make-its-methods-available-fo
    set_language_if_valid(ENV['REDMINE_LANG'])
    # ver o model mailer.rb do Redmine
    # Settings['plugin_tasks']['aceite_tacito_ativo'] => true
    # Settings['plugin_tasks']['aceite_tacito_frequencia'] => 15

    # Model guardar quem/quando rodou a última vez

    # Rake::Task["redmine:avisar_solicitacao_15_dias"].invoke

    # ler dos settings quais tarefas existem
      # está ativa?
        # é hora de rodar? (frequência)
          # rodar
            # Rake::Task[tarefa].invoke

    # require 'rake'
    # RedmineApp::Application.load_tasks # só preciso rodar no rails console. No rake entra em loop.
    # Rake::Task::tasks.collect{|task| task.name}
    # Rake::Task::tasks.select{|task| puts task.name if task.name.starts_with?("redmine") } # vou listar todas na view. Poderia rodar até mesmo db:migrate, porque o root é quem chamará esse script. Restart do apache faremos pelo Jenkins com uma migrate vazio, se precisar.

    # TODO: não pode executar esta tarefa "cron_job". Ela também não deve ser listada na view.

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
        Rake::Task["redmine:#{task.task}"].invoke
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