# Represents a task with the required demographic split data and the user pool to pull from

require './lib/node'
require './lib/User'

class Task
  attr_accessor :user_count
  attr_reader :demographic_groups

  def initialize
    @user_count = 0
    @tree = Node.new
  end

  def users
    User.all
  end

  def add_demographic_split(demo_split)
    @demographic_groups = @tree.create_split(demo_split)
  end

  def split_users
    return users unless @demographic_groups

    splits = {}
    @demographic_groups.each do |keys, percentage|
      users_needed = (percentage * user_count).round
      splits[keys] = User.where(keys).to_a[0...users_needed]
    end
    splits
  end
end
