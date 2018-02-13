require "./rx/*"
require "./*"

# TODO: Write documentation for `Rx`
module Rx

  class Observable(T)
    # class methods
    def self.from_array(array)
        #ObservableArray.new(array)
        Observable.new(ArrayIterator.new array)
    end

    # initializer
    def initialize(@iter : Iterator(T))
    end

    # instance methods
    def subscribe(observer : Observer(T))
      begin
        while true
          item = @iter.next
          if item.is_a? T
            observer.onNext(item)
          else
            break
          end
        end

        observer.onComplete

      rescue ex : Exception
        observer.onError(ex)
      end
    end

    def subscribe(onNext : Proc(T, Nil))
      while true
        item = @iter.next
        if item.is_a? T
          onNext.call(item)
        else # item == Iterator::Stop
          break
        end
      end
    end

    def select(filter : Proc(T, Bool))
      
    end

  end

  class SelectIterator
    def initialize(@iter : Iterator(T), @filter : Proc(T, Bool))
    end

    def subscribe(onNext : Proc(T, Nil))
    end
  end

end
