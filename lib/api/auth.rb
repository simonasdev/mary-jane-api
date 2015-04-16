class Auth < Grape::API
  namespace :auth do
    post do
      @user = User.find_by name: params[:name]

      if @user && @user.authenticate(params[:password])
        { user: UserSerializer.new(@user), token: Token.encode(@user.id) }
      else
        error! 'Invalid credentials', 401
      end
    end
  end
end