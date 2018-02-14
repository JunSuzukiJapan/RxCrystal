require "./spec_helper"
require "./logger"
require "../src/rx"

describe Rx::Observer do
  it "observer" do
    logger = Debug::Logger.new

    observer = Rx::Observer.new(
      ->(x : Int32){ logger.push "#{x}" },
      ->(ex : Exception){ logger.push "Error: #{ex}" },
      ->{ logger.push "Completed" }
    )
    #observer = Rx::Observer.new onNext: ->(x : Int32){ puts x }
    #observer = Rx::Observer(Int32).new onError: ->(e : Exception){ puts "Error" }
    #observer = Rx::Observer(Int32).new onComplete: ->(){ puts "Completed." }
    a = Rx::Observable.from_array [4, 5, 6]
    a.subscribe(observer)

    logger.log.should eq "456Completed"
  end

  it "throw" do
    logger = Debug::Logger.new

    observer = Rx::Observer(Nil).new onError: ->(e: Exception){ logger.push "Error: #{e}"}
    a = Rx::Observable.throw(Exception.new "Some Error")
    a.subscribe(observer)

    logger.log.should eq "Error: Some Error"
  end

  it "empty" do
    logger = Debug::Logger.new

    observer = Rx::Observer.new(
      ->(x : Nil){ logger.push "onNext: #{x}" },
      ->(ex : Exception){ logger.push "onError: #{ex}"},
      ->{ logger.push "empty Completed" }
    )
    a = Rx::Observable.empty
    a.subscribe(observer)

    logger.log.should eq "empty Completed"
  end

  it "never" do
    logger = Debug::Logger.new

    observer = Rx::Observer.new(
      ->(x : Int32){ logger.push "onNext: #{x}" },
      ->(ex : Exception){ logger.push "onError: #{ex}"},
      ->{ logger.push "never Completed" }
    )
    a = Rx::Observable(Int32, Int32).never
    a.subscribe(observer)

    logger.log.should eq ""
  end
end