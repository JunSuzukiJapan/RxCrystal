require "./spec_helper"
require "../src/rx"

describe Rx do
  it "rx" do
    a = Rx::Observable.from_array [4, 5, 6]
#    a.subscribe(->(item : Int32){puts item})
    method = ->(item : Int32){puts item}
    a.subscribe(method)

    observer = Rx::Observer.new(
      ->(item : Int32){ puts item },
      ->(ex : Exception){ puts "Error" },
      ->{ puts "Completed" }
    )
    a = Rx::Observable.from_array [4, 5, 6]
    a.subscribe(observer)


    #    b = Rx::Observable.from_array [7, 8, 9]
    
#    sub = a.zip(b).subscribe { |arr| puts arr.to_s }
    # => "[4, 7]"
    # => "[5, 8]"
    # => "[6, 9]"
    
    # unsubscribes from the sequence and cleans up anything
#    sub.unsubscribe
  end
end
