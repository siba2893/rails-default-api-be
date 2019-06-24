class ApplicationController < ActionController::API
  include Knock::Authenticable
  include Pundit
  include Responsable

  before_action :authenticate_user
  before_action :deep_underscore_params!

  delegate :t, to: I18n

  # protect_from_forgery

  rescue_from Pundit::NotAuthorizedError, with: :unauthorized_entity

  # Response to unauthorized requests
  def unauthorized_entity(_entity_name = nil)
    json_response(errors: ['Usuario no autorizado.'],
                  status: HTTP_CODES[:unauthorized],
                  post_action: :redirect_dashboard)
  end

  def set_locale
    I18n.locale = params[:locale] || I18n.default_locale
  end

  def deep_underscore_params!(app_params = params)
    HashTransformer.snake_case(app_params, mutable: true)
  end
end
