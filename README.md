# RxCrystal

Reactive Extensions for Crystal Language.

## Installation

Add this to your application's `shard.yml`:

```yaml
dependencies:
  rx:
    github: JunSuzukiJapan/RxCrystal
```

## Usage

```crystal
require "rx"
```

## Observer

```
  observer = Rx::Observer.new(
    ->(x : Int32)      { puts "#{x}" },          # OnNext
    ->(ex : Exception) { puts "Error: #{ex}" },  # OnError
    ->()               { puts "Completed" }      # OnCompleted
  )

  a = Rx::Observable.from_array [4, 5, 6]
  a.subscribe(observer)
```    

## Subjects

### Subject

```
  subject = Rx::Subject(Int32).new

  subject.subscribe(
    ->(x : Int32)      { puts "1 onNext: #{x}"},
    ->(ex : Exception) { puts "1 onError"},
    ->()               { puts "1 onComplete"}
  )

  subject.onNext(100)

  subject.subscribe(
    ->(x : Int32)      { puts "2 onNext: #{x}"},
    ->(ex : Exception) { puts "2 onError"},
    ->()               { puts "2 onComplete"}
  )

  subject.onNext(200)
  subject.onComplete()

  # Output:
  # 1 onNext: 100
  # 1 onNext: 200
  # 2 onNext: 200
  # 1 onComplete
  # 2 onComplete  
```

### BehaviorSubject

```
    subject = Rx::BehaviorSubject.new(0)

    subject.subscribe(
      ->(x : Int32)      { puts "1 onNext: #{x}"},
      ->(ex : Exception) { puts "1 onError"},
      ->()               { puts "1 onComplete"}
    )

    subject.onNext(100)

    subject.subscribe(
      ->(x : Int32)      { puts "2 onNext: #{x}"},
      ->(ex : Exception) { puts "2 onError"},
      ->()               { puts "2 onComplete"}
    )

    subject.onNext(200)
    subject.onComplete()

  # Output:
  # 1 onNext: 100
  # 2 onNext: 100
  # 1 onNext: 200
  # 2 onNext: 200
  # 1 onComplete
  # 2 onComplete
```

### Replay Subject

```
    subject = Rx::ReplaySubject(Int32).new(3)
    subject.onNext(1)
    subject.onNext(2)
    subject.onNext(3)
    subject.onNext(4)

    subject.subscribe(
      ->(x : Int32)      { puts "#{x}"},
      ->(ex : Exception) { puts "Error"},
      ->()               { puts "Completed"}
    )

    subject.onNext(5)
    subject.onComplete()

    # Output:
    # 2
    # 3
    # 4
    # 5
    # Completed
 ```

 ### Async Subject

 ```
  subject = Rx::AsyncSubject(Int32).new

  subject.subscribe(
    ->(x : Int32)      { puts "1 onNext: #{x}"},
    ->(ex : Exception) { puts "1 onError"},
    ->()               { puts "1 onComplete"}
  )

  subject.onNext(100)
  subject.onNext(110)
  subject.onNext(120)

  subject.subscribe(
    ->(x : Int32)      { puts "2 onNext: #{x}"},
    ->(ex : Exception) { puts "2 onError"},
    ->()               { puts "2 onComplete"}
  )

  subject.onNext(130)
  subject.onNext(140)
  subject.onNext(200)
  subject.onComplete()

  # Output:  
  # 1 onNext: 200
  # 1 onComplete
  # 2 onNext: 200
  # 2 onComplete
 ```

 ### BindTo

 ```
  subject = Rx::Subject(Int32).new
  subject.subscribe(
    ->(x : Int32)      { puts "onNext: #{x}"},
    ->(ex : Exception) { puts "onError"},
    ->()               { puts "onComplete"}
  )

  a = Rx::Observable.from_array [4, 5, 6]
  a.bindTo(subject)

  subject.onNext(100)
  subject.onComplete()

  # Output:
  # onNext: 4
  # onNext: 5
  # onNext: 6
  # onNext: 100
  # onComplete
```

## Iterators

```
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
    iter = Rx::RangeIterator.new(1, 5)
    iter = Rx::MapIterator.new(iter, ->(x : Int32){ x * x })

    iter.next.should eq 1
    iter.next.should eq 4
    iter.next.should eq 9
    iter.next.should eq 16
    iter.next.should eq 25
    (iter.next.is_a? Iterator::Stop).should be_true
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

  it "take_operator" do
    iter = Rx::RangeIterator.new(0, 5)
    iter = Rx::TakeIterator.new(iter, 3)
    iter.next.should eq 0
    iter.next.should eq 1
    iter.next.should eq 2
    (iter.next.is_a? Iterator::Stop).should be_true
  end

  it "list" do
    list = Rx::Util::List(Int32).new
    list.push_first 1
    list.push_first 2
    list.push_first 3
    iter = list.iter
    iter.next.should eq 3
    iter.next.should eq 2
    iter.next.should eq 1
  end

end
```

## Operators

### Repeat

```
  a = Rx::Observable.range(0, 5)
  a = a.repeat(3)
  ary = [] of Int32
  a.subscribe {|x| ary.push x }
  ary.size.should eq 15
  ary.should eq [0, 1, 2, 3, 4, 0, 1, 2, 3, 4, 0, 1, 2, 3, 4]

  a = Rx::Observable.range(0, 5)
  a = a.repeat(3)
  ary = a.to_ary
  ary.should eq [0, 1, 2, 3, 4, 0, 1, 2, 3, 4, 0, 1, 2, 3, 4]
```

### Take

```
  o = Rx::Observable.from_array [1, 2, 3, 4, 5]
  o = o.take(3)
  o.subscribe {|x| puts "#{x}"}

  # Output:
  # 1
  # 2
  # 3
```

### Filter

```
  a = Rx::Observable.from_array [4, 5, 6, 7, 8, 9, 10]
  a = a.filter {|x| x % 2 == 0}
        .subscribe {|x| puts x}
```

### Map

```
  a = Rx::Observable.from_array [4, 5, 6, 7, 8, 9, 10]
  b = a.filter {|x| x % 2 == 1}
       .map {|x| x * x }
       .subscribe {|x| puts x}
```

### Zip

```
  a = Rx::Observable.from_array [4, 5, 6]
  b = Rx::Observable.from_array [7, 8, 9]
  
  a.zip(b).subscribe { |x| puts x }
```

### Just

```
  a = Rx::Observable.just 1, 2, 3, 4, 5
  a.subscribe {|x| puts x}
```

```
  a = Rx::AnyTypeObservable.just(1, 'A', "string", {2, 'B', "another string"}, 3)
  a.subscribe {|x| puts x.to_s}
```

## Contributing

1. Fork it ( https://github.com/JunSuzukiJapan/RxCrystal/fork )
2. Create your feature branch (git checkout -b my-new-feature)
3. Commit your changes (git commit -am 'Add some feature')
4. Push to the branch (git push origin my-new-feature)
5. Create a new Pull Request

## Contributors

- [JunSuzukiJapan](https://github.com/JunSuzukiJapan) - creator, maintainer
