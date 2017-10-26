web: bundle exec puma -C config/puma.rb
worker: bundle exec sidekiq -q default -q mailers -q billing -c 1
release: bundle exec rails db:migrate
