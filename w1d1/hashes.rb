class MyHashSet

  attr_accessor :store

  def initialize
    @store = Hash.new(false)
  end

  def insert(el)
    @store[el]= true
  end

  def include?(el)
    @store[el]
  end

  def delete(el)
    @store.delete(el) ? true : false
  end

  def to_a
    @store.keys
  end

  def union(set2)
    @store.keys + set2.to_a
  end

  def intersect(set2)
    @store.keys & set2.to_a
  end

  def minus(set2)
    @store.keys - set2.to_a
  end

end

if __FILE__ == $0

  var = MyHashSet.new
  var.insert("1")
  var.insert("2")
  var.insert("3")
  var.insert("4")
  puts var.delete("true")

  var2 = MyHashSet.new
  var2.insert("3")
  var2.insert("4")
  var2.insert("1")

  puts "MyHashSet:"
  puts var.minus(var2)

end
