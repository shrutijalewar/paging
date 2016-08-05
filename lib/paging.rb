require "paging/version"
require "paging/base"
require "paging/calculator"

module Paging
  def self.generate(**options)
    Base.new(options)
  end
end
