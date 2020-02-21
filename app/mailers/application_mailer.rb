# frozen_string_literal: true

class ApplicationMailer < ActionMailer::Base
  default from: "office@nerdgeschoss.de"
  layout "mailer"
end
