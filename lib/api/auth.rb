class Auth < Grape::API
  namespace :auth do
    desc 'Authenticate user with name and password'
    params do
      requires :name, type: String, desc: 'User password'
      requires :password, type: String, desc: 'User password'
    end
    post do
      @user = User.find_by name: params[:name]

      if @user && @user.authenticate(params[:password])
        { user: UserSerializer.new(@user), token: Token.encode(@user.id) }
      else
        error!({ errors: ['Invalid credentials'] }, 500)
      end
    end
  end
end