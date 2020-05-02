#!/bin/bash

# $REDMINE_HOME

bundle install
bundle exec rake redmine:plugins NAME=redmine_agile RAILS_ENV=production
bundle exec rake redmine:plugins NAME=redmine_checklists RAILS_ENV=production
bundle exec rake redmine:plugins NAME=redmine_dmsf RAILS_ENV=production
bundle exec rake redmine:plugins NAME=redmine_incoming_emails RAILS_ENV=production
bundle exec rake redmine:plugins NAME=redmine_slack RAILS_ENV=production
bundle exec rake redmine:plugins NAME=redmine_timesheet_plugin RAILS_ENV=production
bundle exec rake redmine:plugins:migrate RAILS_ENV="production"






