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

  def test_class_collection_all
    assert_equal [@user], User.all
    user = User.new(sex: 'Male', age: 'Adult', nationality: 'French')
    assert_equal [@user, user], User.all
  end

  def test_it_creates_sets_by_attribute
    create_many_users

    male_users = User.user_sets['Male']
    expected_male_users = Set.new(User.all.filter { |u| u.sex == 'Male' })
    assert_equal expected_male_users.length, male_users.length

    female_users = User.user_sets['Female']
    expected_female_users = Set.new(User.all.filter { |u| u.sex == 'Female' })
    assert_equal expected_female_users.length, female_users.length

    # test set intersection
    assert_equal 0, (female_users & male_users).length
  end

  def test_it_filters_by_multiple_attribute
    create_many_users
    male_children = User.where('Male', 'Child')
    expected_male_children = Set.new(User.all.filter { |u| u.sex == 'Male' && u.age == 'Child' })
    assert_equal expected_male_children, male_children
  end

  def create_many_users
    10_000.times do
      User.new(
        sex: %w[Male Female].shuffle.pop,
        age: %w[Adult Child].shuffle.pop,
        nationality: %w[English French Indian Japanese].shuffle.pop)
    end
  end

  def teardown
    User.delete_all
  end
end
