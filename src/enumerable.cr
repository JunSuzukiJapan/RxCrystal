module Rx

  class Enumerable(T)
    def self.from_array(array : Array(T))
      ArrayEnumerable.new array
    end
  end

  class ArrayEnumerable(T)
    def initialize(@array : Array(T))
      @index = 0
    end

    def next : (T | Nil)
      if @index >= @array.size
        return nil
      end

      item = @array[@index]
      @index = @index + 1
      item
    end
  end

end