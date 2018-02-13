module Rx

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