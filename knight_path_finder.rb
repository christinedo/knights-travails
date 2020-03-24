require_relative 'polytree'

class KnightPathFinder

  OFFSETS = [
    [1, 2],
    [2, 1],
    [1, -2],
    [-2, 1],
    [-1, 2],
    [2, -1],
    [-1, -2],
    [-2, -1]
  ]

  def self.valid_moves(position)
    OFFSETS.map do |x, y|
      [position[0] + x, position[1] + y]
    end.select do |row, col|
      row.between?(0, 7) && col.between?(0, 7)
    end
  end

  def initialize(start_position)
    @start_position = start_position
    @considered_positions = [start_position]

    build_move_tree
  end

  def new_move_positions(position)
    valid_positions = self.class.valid_moves(position)

    new_positions = valid_positions.reject do |pos|
      @considered_positions.include?(pos)
    end

    @considered_positions.concat(new_positions)

    new_positions
  end

  def build_move_tree
    @root_node = PolyTreeNode.new(@start_position)
    queue = [@root_node]
    until queue.empty?
      current_node = queue.shift
      moves = new_move_positions(current_node.value)
      moves.each do |move|
        next_node = PolyTreeNode.new(move)
        queue << next_node
        current_node.add_child(next_node)
      end
    end
  end

  def find_path(end_position)
    end_node = @root_node.dfs(end_position)
    trace_path_back(end_node).reverse
  end

  def trace_path_back(end_node)
    path = []

    until end_node.nil?
      path << end_node.value
      end_node = end_node.parent
    end

    path
  end
end

k = KnightPathFinder.new([0, 0])
p k.find_path([6, 2])