require "./rx/*"

# TODO: Write documentation for `Rx`
module Rx
  class Observable(T)
    # class methods
    def self.from_array(array)
        ObservableArray.new(array)
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
          observer.onNext(item)
          i = i + 1
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
        onNext.call(item)
        i = i + 1
      end
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
