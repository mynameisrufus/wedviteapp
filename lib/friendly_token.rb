module FriendlyToken
  def self.make
    SecureRandom.base64(15).tr('+/=lIO0', 'pqrsxyz')
  end
end
