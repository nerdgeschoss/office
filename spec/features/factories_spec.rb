require "rails_helper"

RSpec.describe FactoryBot, type: :feature do
  it "has valid factory descriptions" do
    FactoryBot.lint
  end
end
