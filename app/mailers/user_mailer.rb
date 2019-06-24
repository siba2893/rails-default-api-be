class UserMailer < ApplicationMailer
  def create_user(user)
    @user = user
    mail(to: @user.email, subject: "Creacion de la Cuenta - #{app_name}")
  end

  def forgot_password(user)
    @user = user
    mail(to: @user.email, subject: "Recupera tu Contraseña - #{app_name}")
  end

  def invite_users_to_an_account(user, shared_account_inv, existing_user = nil)
    @user = user
    @account = shared_account_inv
    @existing_user = existing_user
    @destination_url = @existing_user ? 'accept-shared-account-invitation' : 'register'

    mail(to: @account.email, subject: "Invitacion a Cuenta Compartida con #{@user.full_name} - #{app_name}")
  end
end
