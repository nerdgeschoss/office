class PerformSubscriptionJob < ApplicationJob
  def perform(subscription)
    subscription.perform!
  end
end
