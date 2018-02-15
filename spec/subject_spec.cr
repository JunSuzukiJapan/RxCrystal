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

end