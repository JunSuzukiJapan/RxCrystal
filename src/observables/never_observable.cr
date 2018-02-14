require "./cold_observable"

module Rx

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

    def subscribe(
      onNext : Proc(T, Nil) = ->(x : T){},
      onError : Proc(Exception, Nil) = ->(ex : Exception){},
      onComplete : Proc(Nil) = ->(){}
    )
      # do nothing
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