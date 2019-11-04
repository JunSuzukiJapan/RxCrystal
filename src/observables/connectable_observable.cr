require "./cold_observable"
require "../subjects/*"

module Rx
  class ConnectableObservable(T, U)

    def connect
    end
  end

  class ConnectableObservableAdapter(T, U) < ConnectableObservable(T, U)
    def initialize(@soource : Observable(T, U), @subject : Subject(T))
    end
  end

  class Observable(T, U)
    def multicast(@subject : Subject(T))
      ConnectableObservableAdapter.new(self, subject)
    end

    def publish
      self.multicast(Subject(T).new)
    end

    def replay(bufferSize : Int32 = Int32.MAX)
      self.multicast(ReplaySubject.new(bufferSize))
    end
  end
end