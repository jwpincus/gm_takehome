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

    def method_missing(m, *args, &block)
       @user_sets[m.to_s.sub('_users', '')]
    end

    private

    def index_users(users)
        users.each { |user|
            user.context.each { |category, value|
                @user_sets[value.downcase] ||= Set.new
                @user_sets[value.downcase] << user
            }
        }    
    end

end