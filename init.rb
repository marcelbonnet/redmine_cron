require 'redmine'


Redmine::Plugin.register :redmine_cron do
  name 'Redmine job scheduler'
  description ''
  version '1.0.3'
  author_url 'https://github.com/marcelbonnet/'
  url 'https://github.com/marcelbonnet/redmine_cron'
  author 'Marcel Bonnet'

  requires_redmine :version_or_higher => '3.0.0'

  menu :admin_menu, :cron_tasks,
    { :controller => 'cron_tasks', :action => 'index' },
    :caption => :"redmine_cron.tasks",
    :html => { :class => 'icon icon-cron_task'},
    :if => Proc.new { User.current.admin? }
  
end