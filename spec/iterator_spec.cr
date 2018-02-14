require "./spec_helper"
require "./logger"
require "../src/rx"

describe Rx do
  it "range_iterator" do
    iter = Rx::RangeIterator.new(0, 3)
    iter.next.should eq 0
    iter.next.should eq 1
    iter.next.should eq 2
    (iter.next.is_a? Iterator::Stop).should be_true

    iter = Rx::RangeIterator.new(5, 4)
    iter.next.should eq 5
    iter.next.should eq 6
    iter.next.should eq 7
    iter.next.should eq 8
    (iter.next.is_a? Iterator::Stop).should be_true
  end

  it "map_iterator" do
#    iter = Rx::RangeIterator.new(1, 5)
#    iter = Rx::MapIterator.new(iter, ->(x : Int32){ x * x })

#    iter.next.should eq 1
#    iter.next.should eq 4
#    iter.next.should eq 9
#    iter.next.should eq 16
#    iter.next.should eq 25
#    (iter.next.is_a? Iterator::Stop).should be_true
  end

  it "repeat_iterator" do
    iter = Rx::RangeIterator.new(0, 3)
    iter = Rx::RepeatIterator.new(iter, 3)
    iter.next.should eq 0
    iter.next.should eq 1
    iter.next.should eq 2
    iter.next.should eq 0
    iter.next.should eq 1
    iter.next.should eq 2
    iter.next.should eq 0
    iter.next.should eq 1
    iter.next.should eq 2
    (iter.next.is_a? Iterator::Stop).should be_true
  end

end