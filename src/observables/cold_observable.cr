
module Rx
  class Observable(T, U)
    # class methods
    def self.from_array(array : Array(T))
      ColdObservable(T, T).new(ArrayIterator.new array)
    end

    def self.range(start : Int32, end : Int32)
      ColdObservable(Int32, Int32).new(RangeIterator.new(start, end))
    end

    def self.throw(e : Exception)
      ColdObservable(Nil, Nil).new(ErrorIterator(Nil).new e)
    end

    def self.empty
      ColdObservable(Nil, Nil).new(ArrayIterator.new [] of Nil)
    end

    def self.never
      NeverObservable(T).new
    end

    def self.just(arg1 : T)
      ColdObservable(T, T).new(ArrayIterator.new [arg1])
    end

    def self.just(arg1 : T, arg2 : T)
      ColdObservable(T, T).new(ArrayIterator.new [arg1, arg2])
    end

    def self.just(arg1 : T, arg2 : T, arg3 : T)
      ColdObservable(T, T).new(ArrayIterator.new [arg1, arg2, arg3])
    end

    def self.just(arg1 : T, arg2 : T, arg3 : T, arg4 : T)
      ColdObservable(T, T).new(ArrayIterator.new [arg1, arg2, arg3, arg4])
    end

    def self.just(arg1 : T, arg2 : T, arg3 : T, arg4 : T, arg5 : T)
      ColdObservable(T, T).new(ArrayIterator.new [arg1, arg2, arg3, arg4, arg5])
    end

    def self.just(arg1 : T, arg2 : T, arg3 : T, arg4 : T, arg5 : T, arg6 : T)
      ColdObservable(T, T).new(ArrayIterator.new [arg1, arg2, arg3, arg4, arg5, arg6])
    end

    def self.just(arg1 : T, arg2 : T, arg3 : T, arg4 : T, arg5 : T, arg6 : T, arg7 : T)
      ColdObservable(T, T).new(ArrayIterator.new [arg1, arg2, arg3, arg4, arg5, arg6, arg7])
    end

    def self.just(arg1 : T, arg2 : T, arg3 : T, arg4 : T, arg5 : T, arg6 : T, arg7 : T, arg8 : T)
      ColdObservable(T, T).new(ArrayIterator.new [arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8])
    end

    def self.just(arg1 : T, arg2 : T, arg3 : T, arg4 : T, arg5 : T, arg6 : T, arg7 : T, arg8 : T, arg9 : T)
      ColdObservable(T, T).new(ArrayIterator.new [arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8, arg9])
    end

    def self.just(arg1 : T, arg2 : T, arg3 : T, arg4 : T, arg5 : T, arg6 : T, arg7 : T, arg8 : T, arg9 : T, arg10 : T)
      ColdObservable(T, T).new(ArrayIterator.new [arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8, arg9, arg10])
    end

    def unsubscribe
      # do nothing
    end

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

    def filter(&predicate : Proc(T, Bool))
      iter = FilterIterator.new(@iter, predicate)
      ColdObservable(T, T).new iter
    end

    def map(&selector : T -> U)
      iter = MapIterator.new(@iter, selector)
      ColdObservable(T, U).new iter
    end

    def zip(another : Observable(T, T))
      iter = ZipIterator.new(@iter, another.iter)
      ColdObservable(T, Tuple(T, T)).new iter
    end

    #def repeat(count : Int32)
    #  iter = RepeatIterator.new(@iter, count)
    #  ColdObservable(T, T).new iter
    #end

    #def take(count : Int32)
    #  iter = TakeIterator.new(@iter, count)
    #  ColdObservable(T, T).new iter
    #end

  end

  class ColdObservable(T, U) < Observable(T, U)

    # initializer
    def initialize(@iter : Iterator(T))
    end

    getter iter

    # instance methods
    def subscribe(
      onNext : Proc(T, Nil) = ->(x : T){},
      onError : Proc(Exception, Nil) = ->(ex : Exception){},
      onComplete : Proc(Nil) = ->(){}
    )
      observer = Observer(T).new(onNext, onError, onComplete)
      self.subscribe(observer)
    end

    def subscribe(observer : Observer(U))
      begin
        @iter.rewind
        while true
          item = @iter.next
          if item.is_a? U
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
      @iter.rewind
      while true
        item = @iter.next
        if item.is_a? U
          onNext.call(item)
        else # item == Iterator::Stop
          break
        end
      end
    end

  end
end