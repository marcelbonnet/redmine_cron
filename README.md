# Redmine Cron

One cron job to call Rake tasks managed by this plugin.

[![Watch the video](tasks.png)](https://youtu.be/Xnb4m8K4NJ8)

* When creating a new Scheduled Task, the field _Interval_ must be set in _minutes_ .

# Dependencies

- RVM (Ruby Version Manager)

# Installing

```
cd /opt/redmine
RAILS_ENV=production rake redmine:plugins:migrate NAME=redmine_cron
```

## Crontab

An example for Linux crontab to call our task manager every 15 minutes:

```
*/15 * * * * REDMINE_LANG=pt-BR RAILS_ENV=production RUBY_VERSION=2.2.2 /opt/redmine/plugins/redmine_cron/cronjob.sh
```

The shell variables:

- _REDMINE_LANG_ sets the localized messages.
- _RAILS_ENV_ sets the environment (development, test, production, ...)
- _RUBY_VERSION_ sets the Ruby Version. The script calls RVM (Ruby Version Manager)

Everytime _redmine:cron_job_ is called, this plugin will decide if the managed tasks must be run or not.