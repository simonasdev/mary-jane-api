class Token
  JWT_SECRET = 'notsecretatall'
  JWT_ALGORITHM = 'HS512'

  attr_reader :user_id, :payload

  def initialize token
    @payload = JWT.decode(token, JWT_SECRET, JWT_ALGORITHM).first.with_indifferent_access
    @user_id = @payload[:user_id]
  rescue JWT::DecodeError
    nil
  end

  def valid?
    user_id.presence && Time.now < Time.at(payload[:exp].to_i)
  end

  def self.encode user_id
    JWT.encode({ user_id: user_id, exp: (DateTime.now + 30).to_i }, JWT_SECRET, JWT_ALGORITHM)
  end
end