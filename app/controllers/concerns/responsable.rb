module Responsable
  extend ActiveSupport::Concern

  HTTP_CODES = Rack::Utils::SYMBOL_TO_STATUS_CODE
  HTTP_CODES_MSG = Rack::Utils::HTTP_STATUS_CODES

  # Handles basic JSON response
  def json_response(errors: [], messages: [], data: {}, status: nil, post_action: nil, alerter: false )
    status ||= (errors.any? ? HTTP_CODES[:unprocessable_entity] : HTTP_CODES[:accepted])
    render json: {
      errors: errors,
      messages: messages,
      status: status,
      status_text: HTTP_CODES_MSG[status],
      data: HashTransformer.camelize(data.as_json, upper_case: false),
      alerter: alerter,
      post_action: post_action
    }, status: status
  end
end
