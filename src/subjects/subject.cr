require "../observer"

module Rx
  class Observable(T, U)
    def bindTo(subject : Subject(T))
      self.subscribe {|item| subject.onNext(item)}
    end
  end

  class Subscription(T)
    def initialize(@subject : Subject(T), @subscriber : Observer(T))
    end

    def unsubscribe
      @subject.unsubscribe @subscriber
    end
  end

  class Subject(T) < Observer(T)

    def initialize
      super()
      @subscribers = [] of Observer(T)
    end

    def unsubscribe(observer : Observer(T))
      @subscribers.delete observer
    end

    def subscribe(
      onNext : Proc(T, Nil) = ->(x : T){},
      onError : Proc(Exception, Nil) = ->(ex : Exception){},
      onComplete : Proc(Nil) = ->(){}
    )
      observer = Observer(T).new(onNext, onError, onComplete)
      self.subscribe observer
    end

    def subscribe(&onNext : T -> Nil)
      observer = Observer(T).new onNext
      self.subscribe observer
    end

    def subscribe(observer : Observer(T))
      @subscribers.push observer
      Subscription(T).new(self, observer)
    end

    def onNext(item : T)
      @subscribers.each {|subscriber| subscriber.onNext(item) }
    end

    def onError(ex : Exception)
      @subscribers.each {|subscriber| subscriber.onError(ex) }
    end

    def onComplete
      @subscribers.each {|subscriber| subscriber.onComplete() }
    end

    def hasObservers
      @subscribers.size > 0
    end

  end
end