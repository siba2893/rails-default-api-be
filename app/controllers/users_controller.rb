class UsersController < ApplicationController
  skip_before_action :authenticate_user, only: [:create, :change_password, :recover_password, :verify_user]
  before_action :set_user

  # GET /users
  def index
    @users = User.all
    json_response(data: @users)
  end

  # GET /users/1
  def show
    json_response(data: @user)
  end

  # POST /users
  def create
    @user = User.new(user_params)
    @user.role = Role.find_by(slug: 'common_user')

    if @user.save
      UserMailer.create_user(@user).deliver
      json_response(data: @user)
    else
      json_response(errors: @user.errors)
    end
  end

  # PATCH/PUT /users/1
  def update
    if @user.update(user_params)
      json_response(data: @user)
    else
      json_response(errors: @user.errors)
    end
  end

  # DELETE /users/1
  def destroy
    user = User.find_by(params[:id])
    if user.destroy
      return json_response(messages: ['Usuario eliminado con exito.'])
    end

    json_response(errors: [user.errors])
  end

  def recover_password
    user = User.find_by(email: params[:email])
    if user
      user.regenerate_password_reset_token
      UserMailer.forgot_password(user).deliver
      json_response(messages: ['Un correo ha sido enviado a su direccion de correo electronica para que pueda recuperar su contraseña.'])
    else
      json_response(errors: ['Correo no encontrado.'])
    end
  end

  def change_password
    user = User.find_by(password_reset_token: params[:token])
    if user
      user.update(password_reset_token: nil)
      json_response(messages: ['Su contraseña fue actualizada con exito.'])
    else
      json_response(errors: ['Usuario no encontrado.'])
    end
  end

  def verify_user
    return json_response(data: @user.as_json, messages: ['Usuario existe.']) if @user

    json_response(errors: ['Usuario no encontrado.'], post_action: :logout)
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_user
    @user = current_user
  end

  # Only allow a trusted parameter "white list" through.
  def user_params
    params.require(:user).permit(:first_name, :last_name, :email, :password, :password_confirmation)
  end
end
