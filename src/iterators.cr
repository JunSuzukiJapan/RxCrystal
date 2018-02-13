module Rx
  #
  # FilterIterator
  #
  class FilterIterator(T)
    include Iterator(T)

    def initialize(@iter : Iterator(T), @predicate : Proc(T, Bool))
    end

    def next
      while true
        item = @iter.next
        if item.is_a? T
          if @predicate.call(item) 
            return item
          end
        else
          return stop
        end
      end
    end

    def rewind
      @iter.rewind
    end

  end

  #
  # MapIterator
  #
  class MapIterator(T, U)
    include Iterator(T)

    def initialize(@iter : Iterator(T), @method : Proc(T, U))
    end

    def next
      item = @iter.next
      if item.is_a? T
        @method.call(item)
      else
        stop
      end
    end

    def rewind
      @iter.rewind
    end

  end

  #
  # ZipIterator
  #
  class ZipIterator(T)
    include Iterator(T)

    def initialize(@iter1 : Iterator(T), @iter2 : Iterator(T))
    end

    def next
      item1 = @iter1.next
      item2 = @iter2.next
      if item1.is_a? T && item2.is_a? T
        {item1, item2}
      else
        stop
      end
    end

    def rewind
      @iter1.rewind
      @iter2.rewind
    end

  end

end