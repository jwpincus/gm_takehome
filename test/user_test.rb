require 'minitest/autorun'
require './lib/user'

class UserTest < Minitest::Test

    def test_it_exists
        set_user
        Assert @user
    end

    def test_user_has_required_attributes
        assert_equal 'Male', @user.sex
        assert_equal 'Adult', @user.age
        assert_equal 'French', @user.nationality
    end

    private 
    def set_user
        @user = User.new(sex: 'Male', age: 'Adult', nationality: 'French')
    end
end