# Node class for a tree with an arbitrary number of children at each node. 
# Keys: all of the demographic slices that exist between that node and the root, inclusive of self
# Percentage: what percentage of the total user_group is represented by this slice

class Node
  attr_reader :keys, :percentage

  def initialize(key = [], percentage = 1, parent = nil)
    @children = []
    @parent = parent
    if parent
      @keys = @parent.keys + [key]
      @percentage = @parent.percentage * percentage
    else
      @keys = key
      @percentage = percentage
    end
  end

  def create_split(new_values)
    if !@children.empty?
      @children.map do |child|
        child.create_split(new_values)
      end.reduce({}, :merge)
    else
      @children = new_values.map do |demo_key, percentage|
        Node.new(demo_key, percentage, self)
      end
      @children.map do |child|
        { child.keys => child.percentage }
      end.reduce({}, :merge)
    end
  end
end
