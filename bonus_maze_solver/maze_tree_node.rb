class MazeTreeNode

	def initialize(pos)
    @parent = nil
    @children = []
    @pos = pos
  end

  def parent
    @parent
  end

  def parent=(other_parent)
    @parent.children.delete(self) if @parent
    @parent = other_parent
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

  def pos
    @pos
  end

  def map_item
    @map_item
  end

  def bfs(target_pos = nil)
  	raise "Need a target position!" if target_pos.nil?

    queue = [self]
    until queue.empty? 
    	current_node = queue.shift
    	return current_node if current_node.pos == target_pos
      current_node.children.each { |child_node| queue << child_node }
    end

    nil
  end

  def trace_path_back
    return [@pos] unless @parent
    [@pos] + @parent.trace_path_back
  end

end