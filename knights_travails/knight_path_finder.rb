require_relative "poly_tree_node"

class KnightPathFinder

    MOVE_CHANGE = [ [1, -2], [2, -1], [2, 1], [1, 2], [-1, 2], [-2, 1], [-2, -1], [-1, -2] ]

    def self.valid_moves(starting_pos)
        row, col = starting_pos
        moves = []

        MOVE_CHANGE.each do |change|
            new_pos = [row + change[0], col + change[1]]
            moves << new_pos if self.valid_bounds(new_pos)
        end
        moves
    end

    def self.valid_bounds(pos)
        row, col = pos
        row >= 0 && row <= 7 && col >= 0 && col <= 7
    end

    def initialize(starting_pos)
        @considered_positions = [starting_pos]
        @starting_pos = starting_pos
        @moves = []
        @root_node = PolyTreeNode.new(starting_pos, @moves)
    end

    def new_move_positions(starting_pos)
        moves = KnightPathFinder.valid_moves(starting_pos)
        new_moves = moves.select { |move| !@considered_positions.include?(move) }
        @considered_positions += new_moves
        return new_moves
    end

    def build_move_tree
        queue = [@root_node]
        # n = 0
        while !queue.empty?
            current_node = queue.shift
            self.new_move_positions(current_node.value).each do |position|
                current_node.add_child(PolyTreeNode.new(position, []))
                # n += 1
            end
            queue += current_node.children
        end
        p @root_node
        # puts n
        # true
    end
end

kpf = KnightPathFinder.new([0, 1])
# p KnightPathFinder.valid_moves([0, 1])
p kpf.build_move_tree