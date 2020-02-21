# frozen_string_literal: true

class PerformSubscriptionsJob < ApplicationJob
  def perform
    Subscription.due.each { |e| PerformSubscriptionJob.perform_later(e) }
  end
end
