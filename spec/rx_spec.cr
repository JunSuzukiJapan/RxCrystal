require "./spec_helper"
require "./logger"
require "../src/rx"

describe Rx do
  it "enumerable" do
    a = Rx::ArrayIterator.new [1, 2, 3]
    ary = [] of Int32
    a.each { |x| ary.push x }
    (ary <=> [1, 2, 3]).should eq 0
  end

  it "subscribe" do
    logger = Debug::Logger.new

    a = Rx::Observable.from_array [4, 5, 6]
    a.subscribe {|x| logger.push "#{x}"}
    a.subscribe {|x| logger.push "#{x}"}

    logger.log.should eq "456456"
  end

  it "observer" do
    observer = Rx::Observer.new(
      ->(x : Int32){ puts x },
      ->(ex : Exception){ puts "Error: ", ex },
      ->{ puts "Completed" }
    )
    observer = Rx::Observer.new onNext: ->(x : Int32){ puts x }
    observer = Rx::Observer(Int32).new onError: ->(e : Exception){ puts "Error" }
    observer = Rx::Observer(Int32).new onComplete: ->(){ puts "Completed." }
    a = Rx::Observable.from_array [4, 5, 6]
    a.subscribe(observer)
  end

  it "filter" do
    a = Rx::Observable.from_array [4, 5, 6, 7, 8, 9, 10]
    a = a.filter {|x| x % 2 == 0}
    #  .subscribe {|x| puts x}

    ary = a.filter {|x| x % 2 == 0}
      .to_ary
    (ary <=> [4, 6, 8, 10]).should eq 0
    end

  it "map" do
    a = Rx::Observable.from_array [4, 5, 6, 7, 8, 9, 10]
    b = a.filter {|x| x % 2 == 1}
      .map {|x| x * x }
      #.subscribe {|x| puts x}
    ary = b.to_ary
    (ary <=> [25, 49, 81]).should eq 0
  end

  it "zip" do
    a = Rx::Observable.from_array [4, 5, 6]
    b = Rx::Observable.from_array [7, 8, 9]
    
    #a.zip(b).subscribe { |x| puts x }
    ary = a.zip(b).to_ary
    (ary <=> [{4, 7}, {5, 8}, {6, 9}]).should eq 0
  end

  it "just" do
    a = Rx::Observable.just 1, 2, 3, 4, 5
    #a.subscribe {|x| puts x}
    ary = a.to_ary
    (ary <=> [1, 2, 3, 4, 5]).should eq 0
  end

  it "any type just" do
    logger = Debug::Logger.new

    a = Rx::AnyTypeObservable.just(1, 'A', "string", {2, 'B', "another string"}, 3)
    a.subscribe {|x| logger.push x.to_s}

    logger.log.should eq "1Astring{2, 'B', \"another string\"}3"
  end

  it "range" do
    a = Rx::Observable.range(0, 10)
    #a.subscribe {|x| puts x}
    ary = a.to_ary

    ary.size.should eq 10
    (ary <=> [0, 1, 2, 3, 4, 5, 6, 7, 8, 9]).should eq 0
  end

  it "to_ary" do
    a = Rx::Observable.range(0, 10)
    ary = a.to_ary

    ary.size.should eq 10
    (ary <=> [0, 1, 2, 3, 4, 5, 6, 7, 8, 9]).should eq 0
  end

end
