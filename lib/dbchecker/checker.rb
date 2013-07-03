module Dbchecker
  class Checker
    extend DSL

    class << self
      attr_accessor :table
    end

    def self.model(klass)
      self.table = klass.to_s.classify.constantize
    end

  end
end
