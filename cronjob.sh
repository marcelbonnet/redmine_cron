#!/bin/bash --login
# This script should be called by Linux crontab
# 2022-01-26

REDMINE_PATH=$(dirname $(dirname $(dirname $0)))
RENV=${RAILS_ENV:-production}
RVM_VER=${RUBY_VERSION:-2.2.2}

rvm use $RVM_VER

LOGS=$REDMINE_PATH/log/redmine_cron.log
echo "---- CRON JOB BEGIN ----" >> $LOGS
echo "whoami: `whoami`" >> $LOGS
echo "Redmine: $REDMINE_PATH" >> $LOGS
echo "RAILS ENVIRONMENT: ${RENV}" >> $LOGS
echo "RVM: ${RVM_VER}" >> $LOGS
rvm list >> $LOGS
date >> $LOGS
rake -V >> $LOGS
# testing:
# echo "==> TEST STARTED: ls -l $REDMINE_PATH/bin" >> $LOGS
# ls -l $REDMINE_PATH/bin >> $LOGS
# echo "==> TEST FINISHED." >> $LOGS
bash -lc "cd $REDMINE_PATH && RAILS_ENV=$RENV BUNDLE_GEMFILE=$REDMINE_PATH/Gemfile bundle exec rake redmine:cron_job >> $LOGS 2>&1 "
date >> $LOGS
echo "---- CRON JOB END ----" >> $LOGS
