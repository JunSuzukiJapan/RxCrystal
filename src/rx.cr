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

  end

  class ObservableArray(T)
    @array: Array(T)

    # Initializer
    def initialize(array : Array(T))
        @array = array
    end

    # instance methods
    def subscribe(observer : Observer(T))
      begin
        i = 0
        while i < @array.size
          item = @array[i]
          i = i + 1
          observer.onNext(item)
        end
        observer.onComplete
      rescue ex : Exception
        observer.onError(ex)
      end
    end

    def subscribe(onNext : Proc(T, Nil))
      i = 0
      while i < @array.size
        item = @array[i]
        i = i + 1
        onNext.call(item)
      end
    end

    def select(filter : Proc(T, Bool))
      
    end

  end

  class SelectObservable
    def initialize(@filter : Proc(T, Bool))
    end

    def subscribe(onNext : Proc(T, Nil))
    end
  end

  class Observer(T)
    def initialize(@onNext : Proc(T, Nil), @onError : Proc(Exception, Nil), @onComplete : Proc(Nil))
    end

    def onNext(item : T)
      @onNext.call(item)
    end

    def onError(e : Exception)
      @onError.call(e)
    end

    def onComplete
      @onComplete.call()
    end
  end

end
