module Rx
  class RangeIterator
    include Iterator(Int32)

    def initialize(@start : Int32, @end : Int32)
      @current = @start
    end

    def next
      if @current < @end
        result = @current
        @current += 1
        result
      else
        stop
      end
    end

    def rewind
      @current = @start
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