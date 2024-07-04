module Enumerable

  def my_all?
    if block_given?
      self.each do |ele|
        return false unless yield(ele)
      end
      return true
    end
    return false
  end

  def my_any?
    if block_given?
      self.each do |elem|
        if yield(elem)
          return true
        end
      end
    end
    return false
  end

  def my_count
    if block_given?
      self.reduce(0) do |acc, elem|
        if yield(elem)
          acc + 1
        else
          acc
        end
      end
    else
      self.length
    end

  end

  def my_each
    if block_given?
      self.each {|elem| yield(elem)}
    else
      self
    end
  end

  def my_each_with_index
    if block_given?
      index = 0
      self.each do |elem|
        yield(elem, index)
        index += 1
      end
    else
      self
    end
  end

  def my_inject(initial = nil, sym = nil)
    if block_given?
      accumulator = initial.nil? ? self.first : initial
      start_index = initial.nil? ? 1 : 0

      self[start_index..-1].each do |elem|
        accumulator = yield(accumulator, elem)
      end

      accumulator
    elsif initial && sym
      accumulator = initial

      self.each do |elem|
        accumulator = accumulator.send(sym, elem)
      end

      accumulator
    elsif initial.is_a?(Symbol)
      accumulator = self.first
      start_index = 1

      self[start_index..-1].each do |elem|
        accumulator = accumulator.send(initial, elem)
      end

      accumulator
    else
      raise ArgumentError, "no block given"
    end
  end

  def my_map
    result = []
    if block_given?
      self.each {|elem| result <<  yield(elem)}
    else
      return self
    end
    return result
  end

  def my_none?
    if block_given?
      self.each do |elem|
        return false if yield(elem)
      end
    else
      self.each do |elem|
        return false if elem
      end
    end
    true
  end

  def my_select
    if block_given?
      response = []

      self.each do |element|
        if yield(element)
          response << element
        end
      end
      return response
    else
      return self
    end
  end


end

# You will first have to define my_each
# on the Array class. Methods defined in
# your enumerable module will have access
# to this method
class Array
  # Define my_each here
end
