require 'redmine'


Redmine::Plugin.register :redmine_cron do
  name 'Redmine job scheduler'
  description ''
  version '1.0.0'
  author_url 'https://github.com/marcelbonnet/'
  url 'https://github.com/marcelbonnet/redmine_cron'
  author 'Marcel Bonnet'

  requires_redmine :version_or_higher => '3.0.0'

  settings partial: 'settings/redmine_cron.html'
  
end