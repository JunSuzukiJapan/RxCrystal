module Rx
  class RangeIterator
    include Iterator(Int32)

    def initialize(@start : Int32, @count : Int32)
      @index = 0
    end

    def next
      if @index < @count
        result = @start + @index
        @index += 1
        result
      else
        stop
      end
    end

    def rewind
      @index = 0
    end

  end

  class ErrorIterator(T)
    include Iterator(T)

    def initialize(@ex : Exception)
    end

    def next
      raise @ex
    end

    def rewind
      # do nothing
    end

  end

end