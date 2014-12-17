class PolyTreeNode
  def initialize(value)
    @parent = nil
    @children = []
    @value = value
  end

  def parent
    @parent
  end

  def parent=(other_parent)
    # Remove from list of parent's children
    @parent.children.delete(self) if @parent
    @parent = other_parent

    # Add self to parent's children
    other_parent.children = self unless !other_parent
  end

  def add_child(child_node)
    child_node.parent = self
  end

  def remove_child(child_node)
    raise 'TreeError' unless children.include?(child_node)
    child_node.parent = nil
  end

  def children
    @children
  end

  def children=(child)
    @children << child
  end

  def value
    @value
  end

  def dfs(target_value)
    return self if self.value == target_value
    self.children.each do |child_node|
      node = child_node.dfs(target_value)
      return node if node
    end

    nil
  end

  def bfs(target_value)
    queue = []
    queue << self
    until queue.empty? || queue.first.value == target_value
      queue.first.children.each do |child_node|
        queue << child_node
      end
      queue.shift
    end

    return queue.first unless queue.empty?

    nil
  end

  def trace_path_back
    return [@value] unless @parent
    [@value] + @parent.trace_path_back
  end

end
