class UsersController < ApplicationController
  skip_before_action :authenticate_user, only: [:create, :change_password, :recover_password, :verify_user]
  before_action :set_service

  # GET /users
  def index
    json_response(data: User.all)
  end

  # GET /users/1
  def show
    json_response(data: User.find_by(id: params[:id]))
  end

  # POST /users
  def create
    @service.create_common_user
    @service.with_errors ? json_response(errors: @service.errors) : json_response(data: @service.user)
  end

  # PATCH/PUT /users/1
  def update
    @service.update_user
    @service.with_errors ? json_response(errors: @service.errors) : json_response(data: @service.user)
  end

  # DELETE /users/1
  def destroy
    @service.destroy_user
    @service.with_errors ? json_response(errors: @service.errors) : json_response(data: @service.user)
  end

  def recover_password
    @service.user = User.find_by(email: params[:email])
    user = @service.send_recover_password
    user ?
      json_response(messages: ['Un correo ha sido enviado a su direccion de correo electronica para que pueda recuperar su contraseña.']) :
      json_response(errors: ['Correo no encontrado.'])
  end

  def change_password
    @service.user = User.find_by(password_reset_token: params[:token])
    user = @service.change_password
    user ?
      json_response(messages: ['Su contraseña fue actualizada con exito.']) :
      json_response(errors: ['Usuario no encontrado.'])
  end

  def verify_user
    return json_response(data: current_user.as_json, messages: ['Usuario existe.']) if current_user
    json_response(errors: ['Usuario no encontrado.'], post_action: :logout)
  end

  private

  def set_service
    @service ||= UserService.new(params: params)
  end
end
