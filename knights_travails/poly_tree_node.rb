class PolyTreeNode
    attr_reader :value, :parent
    attr_accessor :children

    def initialize(value, children = [])
        @value = value
        @parent = nil
        @children = children
    end

    # def inspect
    #     @value.inspect
    # end

    def parent=(parent)
        # remove self from current parent
        if !@parent.nil?
            @parent.children.delete(self)
        end

        # sets the parent property
        @parent = parent

        # adds the current node to its parent's children if parent exists
        unless @parent.nil?
            @parent.children << self
        end
    end

    def add_child(child_node)
        child_node.parent = self
    end

    def remove_child(child_node)
        # @children.delete(child_node)
        if @children.include?(child_node)
            child_node.parent = nil
        else
            raise "node is not a child"
        end
    end

    def dfs(target_value)
        return self if self.value == target_value
        @children.each do |child|
            res = child.dfs(target_value)
            return res if !res.nil?
        end
        nil
    end

    def bfs(target_value)
        queue = []
        queue << self
        while !queue.empty?
            current_node = queue.shift
            return current_node if current_node.value == target_value
            queue += current_node.children
        end
        nil
    end


end