require './lib/user'
require './lib/users'
require 'minitest/autorun'
require 'set'

class UsersTest < Minitest::Test
    
        def setup
            @users_set = []
            1000.times do
                @users_set << User.new(sex: ['Male', 'Female'].shuffle.pop, age: ['Adult', 'Child'].shuffle.pop, nationality: ['English', 'French', 'Indian', 'Japanese'].shuffle.pop)
            end
        end
    
    def test_it_exists
        assert Users.new
    end

    def test_it_accepts_new_users
        users = Users.new
        assert users.add_new_users(@users_set)
        assert_equal users.all.length, @users_set.length
    end

    def test_it_creates_sets_by_attribute
        users = Users.new
        users.add_new_users(@users_set)
        male_users = users.male_users
        expected_male_users = Set.new(@users_set.filter {|u| u.sex == 'Male'})
        assert_equal expected_male_users, male_users
    end

end