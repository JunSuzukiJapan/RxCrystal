require "./spec_helper"
require "../src/rx"
require "../src/enumerable"

describe Rx do
  it "rx" do
    a = Rx::Observable.from_array [4, 5, 6]
    a.subscribe(->(item : Int32){puts item})

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
    a = Rx::Enumerable.from_array [1, 2, 3]
    while true
      item = a.next
      if item == nil
        break
      end
      puts item
    end
  end
end
