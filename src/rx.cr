require "./rx/*"
require "./*"

# TODO: Write documentation for `Rx`
module Rx

  class Observable(T, U)
    # class methods
    def self.from_array(array : Array(T))
        Observable(T, T).new(ArrayIterator.new array)
    end

    def self.range(start : Int32, end : Int32)
      Observable(Int32, Int32).new(RangeIterator.new(start, end))
    end

    def self.error(e : Exception)
      Observable(Nil, Nil).new(ErrorIterator(Nil).new e)
    end

    def self.empty
      Observable(Nil, Nil).new(ArrayIterator.new [] of Nil)
    end

    def self.never
      NeverObservable(T).new
    end

    def self.just(arg1 : T)
      Observable(T, T).new(ArrayIterator.new [arg1])
    end

    def self.just(arg1 : T, arg2 : T)
      Observable(T, T).new(ArrayIterator.new [arg1, arg2])
    end

    def self.just(arg1 : T, arg2 : T, arg3 : T)
      Observable(T, T).new(ArrayIterator.new [arg1, arg2, arg3])
    end

    def self.just(arg1 : T, arg2 : T, arg3 : T, arg4 : T)
      Observable(T, T).new(ArrayIterator.new [arg1, arg2, arg3, arg4])
    end

    def self.just(arg1 : T, arg2 : T, arg3 : T, arg4 : T, arg5 : T)
      Observable(T, T).new(ArrayIterator.new [arg1, arg2, arg3, arg4, arg5])
    end

    def self.just(arg1 : T, arg2 : T, arg3 : T, arg4 : T, arg5 : T, arg6 : T)
      Observable(T, T).new(ArrayIterator.new [arg1, arg2, arg3, arg4, arg5, arg6])
    end

    def self.just(arg1 : T, arg2 : T, arg3 : T, arg4 : T, arg5 : T, arg6 : T, arg7 : T)
      Observable(T, T).new(ArrayIterator.new [arg1, arg2, arg3, arg4, arg5, arg6, arg7])
    end

    def self.just(arg1 : T, arg2 : T, arg3 : T, arg4 : T, arg5 : T, arg6 : T, arg7 : T, arg8 : T)
      Observable(T, T).new(ArrayIterator.new [arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8])
    end

    def self.just(arg1 : T, arg2 : T, arg3 : T, arg4 : T, arg5 : T, arg6 : T, arg7 : T, arg8 : T, arg9 : T)
      Observable(T, T).new(ArrayIterator.new [arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8, arg9])
    end

    def self.just(arg1 : T, arg2 : T, arg3 : T, arg4 : T, arg5 : T, arg6 : T, arg7 : T, arg8 : T, arg9 : T, arg10 : T)
      Observable(T, T).new(ArrayIterator.new [arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8, arg9, arg10])
    end

    # initializer
    def initialize(@iter : Iterator(T))
    end

    getter iter

    # instance methods
    def to_ary
      ary = [] of U

      while true
        item = @iter.next
        if item.is_a? U
          ary.push item
        else # item == Iterator::Stop
          break
        end
      end

      ary
    end

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

  class NeverObservable(T)
    # initializer
    def initialize
    end

    # instance methods
    def to_ary
      ary = [] of U

      while true
        item = @iter.next
        if item.is_a? U
          ary.push item
        else # item == Iterator::Stop
          break
        end
      end

      ary
    end

    def subscribe(observer : Observer(T))
      # do nothing
    end

    def subscribe(&onNext : U -> Nil)
      # do nothing
    end

    def filter(&predicate : Proc(T, Bool))
      # do nothing
    end

    def map(&block : T -> U)
      # do nothing
    end

    def zip(another : Observable(T, T))
      # do nothing
    end
  end

end
