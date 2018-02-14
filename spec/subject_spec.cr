require "./spec_helper"
require "../src/rx"

describe Rx do

  it "subject" do
    subject = Rx::Subject(Int32).new

    subject.subscribe(
      ->(x : Int32){ puts "1 onNext: #{x}"},
      ->(ex : Exception){ puts "1 onError"},
      ->(){ puts "1 onComplete"}
    )

    subject.onNext(100)

    subject.subscribe(
      ->(x : Int32){ puts "2 onNext: #{x}"},
      ->(ex : Exception){ puts "2 onError"},
      ->(){ puts "2 onComplete"}
    )

    subject.onNext(200)
    subject.onComplete()
  end

end