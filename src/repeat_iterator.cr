module Rx
  class RepeatIterator(T)
    include Iterator(T)

    def initialize(@iter : Iterator(T), @repeat_count : Int32)
      @count = 0
    end

    def next
      item = @iter.next

      unless item.is_a? T
        @count += 1
        if @count >= @repeat_count
          return stop
        end

        @iter.rewind
        item = @iter.next
      end

      item
    end

    def rewind
      @iter.rewind
      @count = 0
    end
  end
end