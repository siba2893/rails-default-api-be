class UserTokenController < Knock::AuthTokenController
  #Default Configuration for Knock
  include Responsable
  skip_before_action :verify_authenticity_token
  rescue_from Knock.not_found_exception_class_name, with: :bad_request

  # Response after successful login
  def create
    user = User.find(auth_token.payload[:sub])
    render json: {
      jwt: auth_token.token,
      user: user.as_json
    }, status: :created
  end

  # When login fail
  def bad_request
    json_response(errors: ['Email o Correo invalido.'])
  end
end
