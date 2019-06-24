class HomeController < ApplicationController
  skip_before_action :authenticate_user

  def index
    render json: { message: (current_user ? 'Logeado' : 'No Logueado'), status: 200 }
  end
end
