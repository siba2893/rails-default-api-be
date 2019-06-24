Rails.application.routes.draw do
  scope :api do
    get 'home/index'
    post 'user_token' => 'user_token#create' # Login

    resources :users do
      collection do
        get :verify_user
        post :recover_password
        post :change_password
      end
    end
  end
end
