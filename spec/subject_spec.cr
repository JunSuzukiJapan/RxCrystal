require "./spec_helper"
require "./logger"
require "../src/rx"

describe Rx do

  it "subject" do
    logger = Debug::Logger.new

    subject = Rx::Subject(Int32).new

    subject.subscribe(
      ->(x : Int32){ logger.pushln "1 onNext: #{x}"},
      ->(ex : Exception){ logger.pushln "1 onError"},
      ->(){ logger.pushln "1 onComplete"}
    )

    subject.onNext(100)

    subject.subscribe(
      ->(x : Int32){ logger.pushln "2 onNext: #{x}"},
      ->(ex : Exception){ logger.pushln "2 onError"},
      ->(){ logger.pushln "2 onComplete"}
    )

    subject.onNext(200)
    subject.onComplete()

    logger.log.should eq "1 onNext: 100
1 onNext: 200
2 onNext: 200
1 onComplete
2 onComplete
"
  end

  it "unsubscribe subject" do
    logger = Debug::Logger.new

    subject = Rx::Subject(Int32).new

    subscription1 = subject.subscribe(
      ->(x : Int32){ logger.pushln "1 onNext: #{x}"},
      ->(ex : Exception){ logger.pushln "1 onError"},
      ->(){ logger.pushln "1 onComplete"}
    )

    subject.onNext(100)

    subscription2 = subject.subscribe(
      ->(x : Int32){ logger.pushln "2 onNext: #{x}"},
      ->(ex : Exception){ logger.pushln "2 onError"},
      ->(){ logger.pushln "2 onComplete"}
    )

    subject.onNext(200)

    subscription1.unsubscribe

    subject.onNext(300)

    subject.onComplete()

    logger.log.should eq "1 onNext: 100
1 onNext: 200
2 onNext: 200
2 onNext: 300
2 onComplete
"
  end

  it "behavior_subject" do
    logger = Debug::Logger.new

    subject = Rx::BehaviorSubject.new(0)

    subject.subscribe(
      ->(x : Int32){ logger.pushln "1 onNext: #{x}"},
      ->(ex : Exception){ logger.pushln "1 onError"},
      ->(){ logger.pushln "1 onComplete"}
    )

    subject.onNext(100)

    subject.subscribe(
      ->(x : Int32){ logger.pushln "2 onNext: #{x}"},
      ->(ex : Exception){ logger.pushln "2 onError"},
      ->(){ logger.pushln "2 onComplete"}
    )

    subject.onNext(200)
    subject.onComplete()

    logger.log.should eq "1 onNext: 0
1 onNext: 100
2 onNext: 100
1 onNext: 200
2 onNext: 200
1 onComplete
2 onComplete
"
  end

  it "replay_subject" do
    logger = Debug::Logger.new

    subject = Rx::ReplaySubject(Int32).new(3)
    subject.onNext(1)
    subject.onNext(2)
    subject.onNext(3)
    subject.onNext(4)

    subject.subscribe(
      ->(x : Int32){ logger.push "#{x}"},
      ->(ex : Exception){ logger.push "Error"},
      ->(){ logger.push "Completed"}
    )

    subject.onNext(5)
    subject.onComplete()

    logger.log.should eq "2345Completed"
  end

  it "dummy" do
    type = "ABCDEFGHIJ"

    (0..type.size).each { |x|
      args = ""
      types = "("
      params = ""

      (0..x).each {|index|
        ch = type[index]
        if index == 0
          args += "arg#{index} : #{ch}"
          types += ch
          params += "arg#{index}"
        else
          args += ", arg#{index} : #{ch}"
          types += " | #{ch}"
          params += ", arg#{index}"
        end
      }
      types += ")"

      puts "    def self.just(#{args})"
      puts "      ColdObservable(#{types}, #{types}).new(ArrayIterator.new [#{params}])"
      puts "    end"
    }
  end

end