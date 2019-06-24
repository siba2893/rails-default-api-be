class ApplicationMailer < ActionMailer::Base
  default from: (Rails.application.credentials.mailer_default_email || 'info@pos.com')
  layout 'mailer'
  add_template_helper(FrontendUrlHelper)

  def app_name
    @app_name ||= 'POS'
  end
end
