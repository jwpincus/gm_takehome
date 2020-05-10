# represents a user with n number of attributes

require 'ostruct'
require 'securerandom'

class User < OpenStruct
  def initialize(args)
    super(args)
    # Uuid needed when using sets
    self.uuid = SecureRandom.uuid
  end

  def context
    to_h
  end
end
