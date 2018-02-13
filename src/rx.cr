require "./rx/*"
require "./*"

# TODO: Write documentation for `Rx`
module Rx

  class Observable(T, U)
    # class methods
    def self.from_array(array : Array(T))
        Observable(T, T).new(ArrayIterator.new array)
    end

    # initializer
    def initialize(@iter : Iterator(T))
    end

    getter iter

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

    def subscribe(&onNext : U -> Nil)
      while true
        item = @iter.next
        if item.is_a? U
          onNext.call(item)
        else # item == Iterator::Stop
          break
        end
      end
    end

    def filter(&predicate : Proc(T, Bool))
      iter = FilterIterator.new(@iter, predicate)
      Observable(T, T).new iter
    end

    def map(&block : T -> U)
      iter = MapIterator.new(@iter, block)
      Observable(T, U).new iter
    end

    def zip(another : Observable(T, T))
      iter = ZipIterator.new(@iter, another.iter)
      Observable(T, Tuple(T, T)).new iter
    end

  end

end
