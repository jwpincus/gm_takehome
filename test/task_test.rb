require './lib/user'
require './lib/users'
require './lib/task'
require 'minitest/autorun'

class TaskTest < Minitest::Test
  def setup
    @users_set = []
    1000.times do
      @users_set << User.new(
        sex: %w[Male Female].shuffle.pop,
        age: %w[Adult Child].shuffle.pop,
        nationality: %w[English French Indian Japanese].shuffle.pop
      )
    end
    @users = Users.new
    @users.add_new_users(@users_set)
  end

  def test_it_exists
    assert Task.new
  end

  def test_task_accepts_user_count
    task = Task.new
    task.users = @users
    assert_equal @users, task.users
  end

  def test_it_can_set_task_demographics
    task = Task.new

    task.add_demographic_split({ 'Male' => 0.5, 'Female' => 0.5 })
    assert_equal 0.50, task.demographic_groups[['Male']]

    task.add_demographic_split({ 'Child' => 0.4, 'Adult' => 0.6 })
    assert_equal 0.20, task.demographic_groups[%w[Male Child]]

    task.add_demographic_split({
        'English' => 0.25,
        'French' => 0.25,
        'Indian' => 0.25,
        'Japanese' => 0.25 
        })
    assert_equal 0.05, task.demographic_groups[%w[Male Child French]]
  end

  def test_it_can_get_appropriate_users
    task = Task.new
    task.user_count = 100
    task.users = @users

    task.add_demographic_split({ 'Male' => 0.5, 'Female' => 0.5 })
    assert_equal 50, task.split_users[['Male']].length

    task.add_demographic_split({ 'Child' => 0.4, 'Adult' => 0.6 })
    assert_equal 20, task.split_users[%w[Male Child]].length

    task.add_demographic_split({
        'English' => 0.25,
        'French' => 0.25,
        'Indian' => 0.25,
        'Japanese' => 0.25 
        })
    assert_equal 5, task.split_users[%w[Male Child French]].length
  end
end
