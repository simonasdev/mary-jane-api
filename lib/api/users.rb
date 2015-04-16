class Users < Grape::API
  resources :users do
    before do
      # authenticate_user!
    end
    
    get do
      User.all
    end

    post do
      User.create declared(params)
    end

    namespace '/:id' do
      before do
        @user = User.find params[:id]
      end

      get do
        @user
      end

      patch do
        @user.update declared(params)
      end

      delete do
        @user.destroy
      end
    end
  end
end