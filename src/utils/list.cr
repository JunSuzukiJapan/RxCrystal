module Rx
  module Util
    private class Cell(T)
      getter head
      property tail

      def initialize(@head : T, @tail : (Cell(T) | Nil))
      end
    end

    class ListIterator(T)
      include Iterator(T)

      def initialize(@iter : (Cell(T) | Nil))
        @head = @iter
      end

      def next
        cell = @iter
        if cell.is_a?(Cell(T))
          item = cell.head
          @iter = cell.tail
          item
        else
          stop
        end
      end

      def rewind
        @iter = @head
      end

    end

    class List(T)
      @head : (Cell(T) | Nil)
      @last : (Cell(T) | Nil)
      @iter : (Cell(T) | Nil)

      def initialize
        @head = nil
        @last = nil
        @iter = @head
      end

      def push_first(item : T)
        if @head.is_a? Nil
          cell = Cell.new(item, nil)
          @head = cell
          @last = @head
        else
          cell = Cell.new(item, @head)
          @head = cell
        end
      end

      def push_last(item : T)
        cell = Cell.new(item, nil)
        if @head.is_a? Nil
          @head = cell
          @last = @head
        else
          @last.tail = cell
          @last = cell
        end
      end

      def iter
        ListIterator.new(@head)
      end
    end

  end
end