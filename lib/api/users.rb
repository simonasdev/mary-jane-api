class Users < Grape::API
  [APIHelper, AuthHelper].each { |helper| helpers helper }

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
      User.create declared_params
    end

    namespace '/:id', requirements: { id: /[0-9]/ } do
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
        @user.update declared_params

        status 204
      end

      desc 'Destroy a user'
      delete do
        @user.destroy

        status 204
      end
    end
  end
end