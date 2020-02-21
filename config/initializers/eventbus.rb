if Sidekiq.server?
  Thread.new do
    Redis.new.subscribe("doorbell") do |on|
      on.message do |channel, message|
        DoorbellRingingJob.perform_later
      end
    end
  end
end
