module Paging
  class Calculator < ::Array

    attr_accessor :list_of_pages, :number_of_pages, :start_page

    def initialize(number_of_pages: number_of_pages,
                   start_page: start_page)
      @number_of_pages = number_of_pages
      @start_page = start_page || 1
      @list_of_pages = (@start_page..@number_of_pages).to_a
    end

    def previous_pages(current_page: current_page,
                       expected_returned: expected_returned,
                       min_page: min_page)
      raise ArgumentError.new("current_page option is required") if current_page.nil?
      raise ArgumentError.new("expected_returned_index option is required") if expected_returned.nil?
      min_page = start_page if min_page.nil?
      return_array = []

      start_page_index = current_page - 2
      expected_returned_index = start_page_index - (expected_returned - 1)

      (expected_returned_index..start_page_index).reverse_each do |page_index|
        break if page_index < (min_page - 1)
        return_array << list_of_pages[page_index]
      end

      return_array.reverse
    end

    def next_pages(current_page: current_page,
                   expected_returned: expected_returned,
                   max_page: max_page)
      raise ArgumentError.new("current_page option is required") if current_page.nil?
      raise ArgumentError.new("expected_returned option is required") if expected_returned.nil?
      max_page = list_of_pages.size if max_page.nil?
      return_array = []

      start_page_index = current_page
      expected_returned_index = start_page_index + (expected_returned - 1)

      (start_page_index..expected_returned_index).each do |page_index|
        break if page_index > (max_page - 1)
        return_array << list_of_pages[page_index]
      end

      return_array
    end
  end
end
