require "./spec_helper"
require "../src/rx"

describe Rx::Observer do
  it "observer" do
    observer = Rx::Observer.new(
      ->(x : Int32){ puts x },
      ->(ex : Exception){ puts "Error: ", ex },
      ->{ puts "Completed" }
    )
    #observer = Rx::Observer.new onNext: ->(x : Int32){ puts x }
    #observer = Rx::Observer(Int32).new onError: ->(e : Exception){ puts "Error" }
    #observer = Rx::Observer(Int32).new onComplete: ->(){ puts "Completed." }
    a = Rx::Observable.from_array [4, 5, 6]
    a.subscribe(observer)
  end

  it "error" do
    observer = Rx::Observer(Nil).new onError: ->(e: Exception){ puts "Error: #{e}"}
    a = Rx::Observable.error(Exception.new "Some Error")
    a.subscribe(observer)
  end
end