# frozen_string_literal: true

class PerformSubscriptionJob < ApplicationJob
  def perform(subscription)
    subscription.perform!
  end
end
