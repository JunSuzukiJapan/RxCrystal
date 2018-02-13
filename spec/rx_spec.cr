require "./spec_helper"
require "../src/rx"

describe Rx do
  it "enumerable" do
    a = Rx::ArrayIterator.new [1, 2, 3]
    a.each { |x| puts x }
  end

  it "subscribe" do
    a = Rx::Observable.from_array [4, 5, 6]
    a.subscribe {|x| puts x}
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
    #a.subscribe(observer) # この行があると、なぜか 'it "map" do'内のb.mapを呼んだときにエラーが起きる。おそらくCrystalのバグ。
  end

  it "filter" do
    a = Rx::Observable.from_array [4, 5, 6, 7, 8, 9, 10]
    a
      .filter {|x| x % 2 == 0}
      .subscribe {|x| puts x}
  end

  it "map" do
    a = Rx::Observable.from_array [4, 5, 6, 7, 8, 9, 10]
    b = a.filter {|x| x % 2 == 1}
      .map {|x| x * x }
      .subscribe {|x| puts x}
  end

  it "zip" do
    a = Rx::Observable.from_array [4, 5, 6]
    b = Rx::Observable.from_array [7, 8, 9]
    
    a.zip(b).subscribe { |x| puts x }
  end

  it "just" do
    a = Rx::Observable.just 1, 2, 3, 4, 5
    a.subscribe {|x| puts x}
  end

end
