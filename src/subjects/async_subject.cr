require "./subject"

module Rx
  class AsyncSubject(T) < Subject(T)
    @last : (T | Nil) = nil

    def onNext(item : T)
      @last = item
    end

    def onComplete
      @subscribers.each { |subscriber|
        if @last.is_a? T
          subscriber.onNext(@last)
        end
        subscriber.onComplete()
      }
    end

  end
end