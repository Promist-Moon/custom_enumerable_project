module Enumerable
  def my_find
    self.each do |elem|
      return elem if yield(elem)
    end

    nil
  end

  def my_all?(pattern = nil)
    if block_given?
      for element in self
        return false unless yield(element)
      end
    elsif pattern
      for element in self
        if pattern.is_a?(Class)
          return false unless element.is_a?(pattern) 
        elsif pattern.is_a?(Regexp)
          return false unless element =~ pattern
        else
          return false unless element == pattern
        end
      end
    else
      for element in self
        return false unless element
      end
    end
    true
  end

  def my_any?(pattern = nil)
    if block_given?
      for element in self
        if yield(element)
          return true
        end
      end
    elsif pattern
      for element in self
        if pattern.is_a?(Class)
          if element.is_a?(pattern) 
            return true
          end
        elsif pattern.is_a?(Regexp)
          if element =~ pattern
            return true
          end
        else
          if element == pattern
            return true
          end
        end
      end
    else
      for element in self
        if element
          return true
        end
      end
    end
    false
  end

  def my_count
    count = 0
    if block_given?
      for element in self
        if yield(element)
          count += 1
        end
      end
    else
      for element in self
        count += 1
      end
    end
    return count
  end

  def my_each_with_index
    return to_enum(:my_each_with_index) unless block_given?
    index = 0
    for element in self
      yield(element, index)
      index += 1
    end
  end

  def my_inject(initial = nil, sym = nil)
    
    if block_given?
      accumulator = initial || self.first  
      start_index = initial ? 0 : 1 
      self[start_index..-1].each do |element|
        accumulator = yield(accumulator, element)
      end
      accumulator
    elsif sym.is_a?(Symbol)
      self[1..-1].inject(self.first, sym)
    else
      raise ArgumentError, "Either a block or a symbol is required."
    end
  end
  

  def my_map
    result = []
    if block_given?
      for element in self
        result << yield(element)
      end
    end
    return result
  end

  def my_none?(pattern = nil)
    if block_given?
      for element in self
        return false if yield(element)
      end
    elsif pattern
      for element in self
        if pattern.is_a?(Class)
          return false if element.is_a?(pattern) 
        elsif pattern.is_a?(Regexp)
          return false if element =~ pattern
        else
          return false if element == pattern
        end
      end
    else
      for element in self
        return false if element
      end
    end
    true
  end

  def my_select
    result = []
    if block_given?
      for element in self
        result << element if yield(element)
      end
    end
    return result
  end
end

# You will first have to define my_each
# on the Array class. Methods defined in
# your enumerable module will have access
# to this method
class Array
  # Define my_each here
  def my_each
    return to_enum(:my_each) unless block_given?
    for element in self
      yield(element)
    end
  end
end
