require "./subject"

module Rx
  class BehaviorSubject(T) < Subject(T)
    def initialize(init_value : T)
      super()
      @current = init_value
    end

    def subscribe(observer : Observer(T))
      observer.onNext(@current)
      super(observer)
    end

    def onNext(item : T)
      @current = item
      @subscribers.each {|subscriber| subscriber.onNext(item) }
    end

    def onError(ex : Exception)
      @subscribers.each {|subscriber| subscriber.onError(ex) }
    end

    def onComplete
      @subscribers.each {|subscriber| subscriber.onComplete() }
    end

  end
end