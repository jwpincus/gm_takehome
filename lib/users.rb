# Holds all users, and indexes them by attribute

require 'set'

class Users
  attr_reader :all, :user_sets

  def initialize
    @all = []
    @user_sets = {}
  end

  def add_new_users(users_array)
    @all += users_array
    index_users(users_array)
  end

  private

  def index_users(users)
    users.each do |user|
      user.context.values.each do |value|
        @user_sets[value] ||= Set.new
        @user_sets[value] << user
      end
    end
  end
end
