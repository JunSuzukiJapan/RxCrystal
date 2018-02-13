require "./spec_helper"
require "../src/rx"

describe Rx do
  it "rx" do
    a = Rx::Observable.from_array [4, 5, 6]
    a.subscribe {|item| puts item}

    observer = Rx::Observer.new(
      ->(item : Int32){ puts item },
      ->(ex : Exception){ puts "Error: ", ex },
      ->{ puts "Completed" }
    )
    a = Rx::Observable.from_array [4, 5, 6]
    a.subscribe(observer)


    a = Rx::Observable.from_array [4, 5, 6]
    b = Rx::Observable.from_array [7, 8, 9]
    
#    sub = a.zip(b).subscribe { |arr| puts arr.to_s }
    # => "[4, 7]"
    # => "[5, 8]"
    # => "[6, 9]"
    
    # unsubscribes from the sequence and cleans up anything
#    sub.unsubscribe
  end

  it "enumerable" do
    a = Rx::ArrayIterator.new [1, 2, 3]
    a.each { |x| puts x }
  end

  it "select" do
    a = Rx::Observable.from_array [4, 5, 6, 7, 8, 9, 10]
    a
      .filter {|item| item % 2 == 0}
      .subscribe {|item| puts item}
  end

#  it "map" do
#    a = Rx::Observable.from_array [4, 5, 6, 7, 8, 9, 10]
#    b = a.map {|x| x.to_s }
#    b.subscribe {|x| puts x}
#  end

end
