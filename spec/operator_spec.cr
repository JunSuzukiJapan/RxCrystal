require "./spec_helper"
require "./logger"
require "../src/rx"

describe Rx do

  #it "repeat" do
    #logger = Debug::Logger.new

    #a = Rx::Observable.range(0, 5)
    #a = a.repeat(3)

    #ary = [] of Int32
    #a.subscribe {|x| ary.push x }
    #(ary <=> [0, 1, 2, 3, 4, 0, 1, 2, 3, 4, 0, 1, 2, 3,4]).should eq 0

    #ary = a.to_ary # ERROR: 無限ループに陥る。
    #(ary <=> [0, 1, 2, 3, 4, 0, 1, 2, 3, 4, 0, 1, 2, 3,4]).should eq 0

    #a.subscribe {|x| logger.push "#{x}"}
    #logger.log.should eq "012340123401234"
  #end

#  it "take" do
#    logger = Debug::Logger.new
#
#    o = Rx::Observable.from_array [1, 2, 3, 4, 5]
#    o = o.take(3)
#
#    #o.subscribe {|x| logger.push "#{x}"}
#    #logger.log.should eq "123"
#  end
end