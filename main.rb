class Node
  attr_accessor :data, :left, :right
  def initialize(data=nil)
    @data = data
    @left = nil
    @right = nil
  end
end

class Tree
  attr_accessor :array, :root
  def initialize(array)
    @array = array.sort.uniq
    @root = self.build_tree
  end

  def insert(value, root=self.root)

    return root = Node.new(value) if root.nil?

      if root.data == value
        return root
      elsif value < root.data
        root.left = insert(value, root.left)
      elsif value > root.data
       root.right = insert(value, root.right)
      end

    return root   
  end

  def delete(value, root=self.root)

   return root if root.nil?

   if value < root.data
    root.left = delete(value, root.left)

   elsif value > root.data
    root.right = delete(value, root.right)

   else
    if root.left.nil?
      temp = root.right
      root = nil
      return temp
    elsif root.right.nil?
      temp = root.left
      root = nil
      return temp
    end

    temp = min_value(root.right)
    root.data = temp.key
    root.right = delete(temp.key, root.right)
  end

  return root  
  end

  def find(value, root=self.root)
    return root if root.nil?   
    if value > root.data
      node = find(value, root.right) 
    elsif value < root.data
      node = find(value, root.left)     
    else
      return node = root
    end
    return node
  end

  def level_order(node=self.root)
    return node if node.nil?
    queue = []
    arr = []
    queue << node

    while !(queue.empty?)
      current = queue.first
      queue << current.left if current.left != nil
      queue << current.right if current.right != nil
      arr << queue.shift.data
    end
    
    return arr

  end

  def inorder(arr = [], root=self.root)
    return arr if root.nil?

    if root
      inorder(arr, root.left)
      arr << root.data
      inorder(arr, root.right)
    end
  end

  def preorder(arr = [], root=self.root)
    return arr if root.nil?

    if root
      arr << root.data
      inorder(arr, root.left)
      inorder(arr, root.right)
    end
  end

  def postorder(arr = [], root=self.root)
    return arr if root.nil?

    if root
      inorder(arr, root.left)
      inorder(arr, root.right)
      arr << root.data
    end
  end

  def height(node=self.root)
    return 0 if node.nil?
    return max(height(node.left), height(node.right)) + 1
  end

  def depth(node=self.root)
    return 0 if node.nil?

    left_depth = depth(node.left)
    right_depth = depth(node.right)

    left_depth > right_depth ? left_depth + 1 : right_depth + 1
  end

  def balance?
    left_root = height(self.root.left)
    right_root = height(self.root.right)
    arr = [left_root, right_root]
    if (arr.max - arr.min) <= 1
      puts "tree is balanced"
      true
    else
      puts "tree is not balanced"
      false
    end
  end

  def rebalance
    level_order_array = self.level_order
    self.root = build_tree(level_order_array)
  end

  def pretty_print(node = @root, prefix = '', is_left = true)
    pretty_print(node.right, "#{prefix}#{is_left ? '│   ' : '    '}", false) if node.right
    puts "#{prefix}#{is_left ? '└── ' : '┌── '}#{node.data}"
    pretty_print(node.left, "#{prefix}#{is_left ? '    ' : '│   '}", true) if node.left
  end

 

  private


def build_tree(array=arr, start=0, last=array.length-1)
  return nil if start > last

  mid = (start + last) / 2
  node = Node.new(array[mid])

  node.left = build_tree(array, start, mid - 1)
  node.right = build_tree(array, mid + 1, last)

  return node
end

def arr
  self.array
end

def min_value(node)
  current = node
    current = current.left unless current.nil?
  return current
end

def max(a, b)
 return a >= b ? a : b
end

end


# new_tree = Tree.new([1,3,4,6,8,10,14,13])
# p new_tree.inorder
# new_tree.insert(2)
# new_tree.insert(7)
# new_tree.insert(15)
# p new_tree.inorder
# new_tree.delete(2)
# p new_tree.inorder
# p new_tree.find(2)
# p new_tree.find(3)
# p new_tree.level_order
# p new_tree.height
# p new_tree.depth
# new_tree.pretty_print
# new_tree.balance?
# new_tree.rebalance
# new_tree.pretty_print
# new_tree.balance?
arr = (Array.new(15) {rand(1..100)})
new_tree = Tree.new(arr)
new_tree.pretty_print
new_tree.balance?
p new_tree.level_order
p new_tree.preorder
p new_tree.inorder
p new_tree.postorder
new_tree.insert(101)
new_tree.insert(122)
new_tree.insert(133)
new_tree.pretty_print
new_tree.balance?
new_tree.rebalance
new_tree.pretty_print
new_tree.balance?
p new_tree.preorder
p new_tree.inorder
p new_tree.postorder