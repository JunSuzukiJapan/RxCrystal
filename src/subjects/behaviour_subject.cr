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

  end
end