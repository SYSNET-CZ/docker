#!/bin/bash
set -e

case "$1" in
	rails|rake|passenger)
		if [ ! -f './config/database.yml' ]; then
		  export REDMINE_DB_MYSQL=db
		  adapter='mysql2'
		  host="$REDMINE_DB_MYSQL"
		  : "${REDMINE_DB_PORT:=3306}"
		  : "${REDMINE_DB_USERNAME:=${MYSQL_ENV_MYSQL_USER:-root}}"
			: "${REDMINE_DB_PASSWORD:=${MYSQL_ENV_MYSQL_PASSWORD:-${MYSQL_ENV_MYSQL_ROOT_PASSWORD:-}}}"
			: "${REDMINE_DB_DATABASE:=${MYSQL_ENV_MYSQL_DATABASE:-${MYSQL_ENV_MYSQL_USER:-redmine}}}"
			: "${REDMINE_DB_ENCODING:=}"

			export REDMINE_DB_ADAPTER="$adapter"
			export REDMINE_DB_HOST="$host"
			echo "$RAILS_ENV:" > config/database.yml
			for var in \
				adapter \
				host \
				port \
				username \
				password \
				database \
				encoding \
			; do
				env="REDMINE_DB_${var^^}"
				val="${!env}"
				[ -n "$val" ] || continue
				echo "  $var: \"$val\"" >> config/database.yml
			done
		fi

		# ensure the right database adapter is active in the Gemfile.lock
		bundle install --without development test

		if [ ! -s config/secrets.yml ]; then
			if [ "$REDMINE_SECRET_KEY_BASE" ]; then
				cat > 'config/secrets.yml' <<-YML
					$RAILS_ENV:
					  secret_key_base: "$REDMINE_SECRET_KEY_BASE"
				YML
			elif [ ! -f /usr/src/redmine/config/initializers/secret_token.rb ]; then
				rake generate_secret_token
			fi
		fi
		if [ "$1" != 'rake' -a -z "$REDMINE_NO_DB_MIGRATE" ]; then
			gosu redmine rake db:migrate
		fi

		chown -R redmine:redmine files log public/plugin_assets

		# remove PID file to enable restarting the container
		rm -f /usr/src/redmine/tmp/pids/server.pid

		if [ "$1" = 'passenger' ]; then
			# Don't fear the reaper.
			set -- tini -- "$@"
		fi

		set -- gosu redmine "$@"
		;;
esac

exec "$@"