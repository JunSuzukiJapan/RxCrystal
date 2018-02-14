module Debug
  class Logger
    getter log

    def initialize
      @log = ""
    end

    def push(s : String) : Nil
      @log += "#{s}\n"
    end

  end
end