class BaseService
  attr_accessor :current_user, :params, :errors

  def initialize(current_user: nil, params: {}, user: nil)
    @current_user = current_user
    @params = params
    @errors = []
  end

  def with_errors
    @errors.size > 0
  end

  private

  def respond_with(record)
    (@errors = record.errors.full_messages) and record
  end
end
