module AuthHelper
  def authenticate_user!
    unauthorized! unless current_user
  end

  def unauthorized!
    error! '', 401
  end

  def set_current_user
    token = request.headers['Authorization'].to_s.split(' ').last
    return unless token

    payload = Token.new(token)

    User.find(payload.user_id) if payload.valid?
  end
end