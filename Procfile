web: bundle exec puma -C config/puma.rb
worker: bundle exec sidekiq -q default -q mailers -q billing -c 1
release: [ -z "$ROOT_DATABASE_URL" ] || DATABASE_URL=$ROOT_DATABASE_URL bundle exec rails db:migrate
