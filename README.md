# Redmine Cron

One cron job to call Rake tasks managed by this plugin.

An example for Linux crontab to call our task manager every 15 minutes:

```
*/15 * * * * REDMINE_LANG=pt-BR rake redmine:cron_job
```

The shell variable _REDMINE_LANG_ sets the localized messages.

Everytime _redmine:cron_job_ is called, this plugin will decide if the managed tasks must be run or not.