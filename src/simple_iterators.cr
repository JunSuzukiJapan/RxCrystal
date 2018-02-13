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

end