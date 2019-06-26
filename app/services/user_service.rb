class UserService < BaseService
  attr_accessor :params

  def initialize(current_user: nil, params:, user: nil)
    super(current_user: current_user, params: params)
    @user = user
  end

  def create_common_user
    user = User.new(user_params)
    user.role = Role.find_by(slug: 'common_user')
    user.save
    respond_with user
  end

  def update_user
    user = which_user
    return unless user
    user.update_attributes(user_params)
    respond_with user
  end

  def destroy_user
    user = which_user
    return unless user
    user.destroy
    respond_with user
  end

  def send_recover_password
    return unless user
    user.regenerate_password_reset_token
    UserMailer.forgot_password(user).deliver
    respond_with user
  end

  def change_password
    return unless user
    user.update(password_reset_token: nil) if user.update_attributes(user_params)
    respond_with user
  end

  private

  def which_user
    if user
      user
    elsif params[:id].present?
      User.find_by(id: params[:user_id]) || User.find_by(id: params[:id])
    else
      current_user
    end
  end

  def user_params
    params.require(:user).permit(:first_name, :last_name, :email, :password, :password_confirmation)
  end
end
