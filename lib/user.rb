# represents a user with n number of attributes

require 'ostruct'
require 'securerandom'
require 'set'

class User < OpenStruct
  class << self; attr_reader :all, :user_sets; end

  @all = []
  @user_sets = {}

  def initialize(args)
    super(args)

    # Uuid needed when using sets since OStruct compares on hashed keys:values
    self.uuid = SecureRandom.uuid
    User.add_new_user(self)
  end

  def self.add_new_user(user)
    @all << user
    index_user(user)
  end

  def self.index_user(user)
    user.to_h.values.each do |value|
      @user_sets[value] ||= Set.new
      @user_sets[value] << user
    end
  end

  def self.where(*keys)
    keys.flatten.map do |key|
      User.user_sets[key]
    end.reduce(:&)
  end

  def self.delete_all
    @all = []
    @user_sets = {}
  end
end
