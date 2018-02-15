require "./subject"

module Rx
  class ReplaySubject(T) < Subject(T)
    def initialize(@bufferSize : Int32 = Int32.MAX)
      super()
      @buffer = Array(T).new @bufferSize
      @itemCount = 0
    end

    def subscribe(observer : Observer(T))
      (0...@itemCount).each {|index| observer.onNext(@buffer[index]) }
      super(observer)
    end

    def onNext(item : T)
      if @itemCount == @bufferSize
        # slide items
        i = 0
        while i < @bufferSize-1
          @buffer[i] = @buffer[i+1]
          i += 1
        end

        @buffer[@itemCount-1] = item

      else
        @buffer.push item
        @itemCount += 1
      end

      @subscribers.each {|subscriber| subscriber.onNext(item) }
    end

  end
end