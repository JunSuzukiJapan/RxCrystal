module Rx
  class AnyTypeObservable(A, B, C, D, E, F, G, H, I, J)
    def self.just(arg0 : A)
      ColdObservable(A, A).new(ArrayIterator.new [arg0])
    end
    def self.just(arg0 : A, arg1 : B)
      ColdObservable((A | B), (A | B)).new(ArrayIterator.new [arg0, arg1])
    end
    def self.just(arg0 : A, arg1 : B, arg2 : C)
      ColdObservable((A | B | C), (A | B | C)).new(ArrayIterator.new [arg0, arg1, arg2])
    end
    def self.just(arg0 : A, arg1 : B, arg2 : C, arg3 : D)
      ColdObservable((A | B | C | D), (A | B | C | D)).new(ArrayIterator.new [arg0, arg1, arg2, arg3])
    end
    def self.just(arg0 : A, arg1 : B, arg2 : C, arg3 : D, arg4 : E)
      ColdObservable((A | B | C | D | E), (A | B | C | D | E)).new(ArrayIterator.new [arg0, arg1, arg2, arg3, arg4])
    end
    def self.just(arg0 : A, arg1 : B, arg2 : C, arg3 : D, arg4 : E, arg5 : F)
      ColdObservable((A | B | C | D | E | F), (A | B | C | D | E | F)).new(ArrayIterator.new [arg0, arg1, arg2, arg3, arg4, arg5])
    end
    def self.just(arg0 : A, arg1 : B, arg2 : C, arg3 : D, arg4 : E, arg5 : F, arg6 : G)
      ColdObservable((A | B | C | D | E | F | G), (A | B | C | D | E | F | G)).new(ArrayIterator.new [arg0, arg1, arg2, arg3, arg4, arg5, arg6])
    end
    def self.just(arg0 : A, arg1 : B, arg2 : C, arg3 : D, arg4 : E, arg5 : F, arg6 : G, arg7 : H)
      ColdObservable((A | B | C | D | E | F | G | H), (A | B | C | D | E | F | G | H)).new(ArrayIterator.new [arg0, arg1, arg2, arg3, arg4, arg5, arg6, arg7])
    end
    def self.just(arg0 : A, arg1 : B, arg2 : C, arg3 : D, arg4 : E, arg5 : F, arg6 : G, arg7 : H, arg8 : I)
      ColdObservable((A | B | C | D | E | F | G | H | I), (A | B | C | D | E | F | G | H | I)).new(ArrayIterator.new [arg0, arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8])
    end
    def self.just(arg0 : A, arg1 : B, arg2 : C, arg3 : D, arg4 : E, arg5 : F, arg6 : G, arg7 : H, arg8 : I, arg9 : J)
      ColdObservable((A | B | C | D | E | F | G | H | I | J), (A | B | C | D | E | F | G | H | I | J)).new(ArrayIterator.new [arg0, arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8, arg9])
    end

  end  
end