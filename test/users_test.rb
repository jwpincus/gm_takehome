require './lib/user'
require './lib/users'
require 'minitest/autorun'
require 'set'

class UsersTest < Minitest::Test
  def setup
    @users_set = []
    1000.times do
      @users_set << User.new(
        sex: %w[Male Female].shuffle.pop,
        age: %w[Adult Child].shuffle.pop,
        nationality: %w[English French Indian Japanese].shuffle.pop)
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
    
    male_users = users.user_sets['Male']
    expected_male_users = Set.new(users.all.filter { |u| u.sex == 'Male' })
    assert_equal expected_male_users.length, male_users.length

    female_users = users.user_sets['Female']
    expected_female_users = Set.new(users.all.filter { |u| u.sex == 'Female' })
    assert_equal expected_female_users.length, female_users.length

    # test set intersection
    assert_equal 0, (female_users & male_users).length
  end
end
