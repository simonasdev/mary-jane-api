class Users < Grape::API
  resources :users do
    before do
      # authenticate_user!
    end
    
    desc 'Get all users'
    get do
      User.all
    end

    desc 'Create a user'
    params do
      requires :name, type: String, desc: "User name"
      requires :password, type: String, desc: "User password"
      optional :photo, type: String, desc: "User photo as base64"
    end
    post do
      User.create declared(params)
    end

    namespace '/:id' do
      before do
        @user = User.find params[:id]
      end

      desc 'Get a user'
      get do
        @user
      end

      desc 'Update a user'
      params do
        optional :name, type: String, desc: "User name"
        optional :password, type: String, desc: "User password"
        optional :photo, type: String, desc: "User photo as base64"
      end
      patch do
        @user.update declared(params)
      end

      desc 'Destroy a user'
      delete do
        @user.destroy
      end
    end
  end
end