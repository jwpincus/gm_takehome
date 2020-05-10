require 'minitest/autorun'
require './lib/user'

class UserTest < Minitest::Test

  def setup
    @user = User.new(sex: 'Male', age: 'Adult', nationality: 'French')
  end  

  def test_it_exists
    assert @user
  end

  def test_user_has_required_attributes
    assert_equal 'Male', @user.sex
    assert_equal 'Adult', @user.age
    assert_equal 'French', @user.nationality
  end

  def test_user_context
    assert_instance_of Hash, @user.context
    assert_equal 'Male', @user.context[:sex]
  end
end
