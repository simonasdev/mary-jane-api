class User < ActiveRecord::Base
  has_many :records

  has_secure_password

  def password_digest= password
    self.encrypted_password = password
  end

  def password_digest
    encrypted_password
  end
end