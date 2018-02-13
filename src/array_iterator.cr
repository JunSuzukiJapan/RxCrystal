module Rx

  class ArrayIterator(T)
    include Iterator(T)

    def initialize(@array : Array(T))
      @index = 0
    end

    def next
      if @index < @array.size
        item = @array[@index]
        @index = @index + 1
        item
      else
        stop
      end
    end

    def rewind
      @index = 0
    end

  end

end