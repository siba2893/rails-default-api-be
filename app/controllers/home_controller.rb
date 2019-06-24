class HomeController < ApplicationController
  def index
    render json: { message: (current_user ? 'Logeado' : 'No Logueado'), status: 200 }
  end
end
