web: bundle exec puma -C config/puma.rb
worker: bundle exec sidekiq -C config/sidekiq.yml -c 2
release: bundle exec rails db:migrate
