class JwtService
  def self.encode(payload)
    JWT.encode(payload, Rails.application.secrets.secret_key_base, 'HS256')
  end

  def self.decode(token)
    # trailing comma skips the second returned value of JWT.decode, the
    #   headers, which we don't need
    body, = JWT.decode(token, Rails.application.secrets.secret_key_base,
                       true, algorithm: 'HS256')
    HashWithIndifferentAccess.new(body)
  rescue JWT::ExpiredSignature
    nil
  end
end
