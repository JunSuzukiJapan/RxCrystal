require "./spec_helper"
require "../src/rx"

describe Rx do

  it "repeat" do
    a = Rx::Observable.range(0, 5)
    a = a.repeat(3)

    ary = [] of Int32
    a.subscribe {|x| ary.push x}
    #ary = a.to_ary # ERROR: 無限ループに陥る。
    (ary <=> [0, 1, 2, 3, 4, 0, 1, 2, 3, 4, 0, 1, 2, 3,4]).should eq 0
  end  
end