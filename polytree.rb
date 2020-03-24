class PolyTreeNode
  attr_reader :value, :parent, :children

  def initialize(value)
    @value = value
    @parent = nil
    @children = []
  end

  def parent=(node)
    old_parent = @parent

    # Assign new parent node
    @parent = node

    if old_parent
      # Remove self from old parent's children list on reassignment
      old_parent.children.delete(self)
    end

    if @parent
      # Prevent adding duplicate nodes
      node.children << self if !node.children.include?(self)
    end
  end

  def add_child(child_node)
    child_node.parent = self
  end

  def remove_child(child_node)
    if self.children.include?(child_node)
      child_node.parent = nil
    else
      raise "Child node does not exist!"
    end
  end

  def dfs(target_value)
    return self if self.value == target_value

    @children.each do |child|
      result = child.dfs(target_value)
      return result until result.nil?
    end
    nil
  end

  def bfs(target_value)
    queue = [self]
    until queue.empty?
      current_node = queue.shift

      return current_node if current_node.value == target_value

      current_node.children.each { |child| queue << child }
    end
    nil
  end

  def inspect
    { 'value' => @value, 'parent' => @parent }.inspect
  end
end