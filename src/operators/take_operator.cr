module Rx
  #
  # TakeIterator
  #
  class TakeIterator(T)
    include Iterator(T)

    def initialize(@iter : Iterator(T), @takeCount : Int32)
      @count = 0
    end

    def next
      return stop if @count >= @takeCount

      item = @iter.next
      if item.is_a? T
        @count += 1
        item
      else
        stop
      end
    end

    def rewind
      @iter.rewind
    end

  end
end