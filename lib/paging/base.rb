module Paging
    class Base
        attr_accessor :current_page, :number_of_pages, :number_of_previous_pages,
                      :number_of_next_pages, :previous_pages, :next_pages,
                      :start_page

        def initialize(current_page: current_page,
                       number_of_pages: number_of_pages,
                       number_of_previous_pages: number_of_previous_pages,
                       number_of_next_pages: number_of_next_pages,
                       start_page: start_page)
            raise ArgumentError, 'current_page option is required' if current_page.nil?
            raise ArgumentError, 'number_of_pages option is required' if number_of_pages.nil?
            @current_page = current_page
            @number_of_pages = number_of_pages
            @number_of_previous_pages = number_of_previous_pages || 5
            @number_of_next_pages = number_of_next_pages || 5
            @start_page = start_page || 1
            @calculator = Calculator.new(number_of_pages: @number_of_pages,
                                         start_page: @start_page)
            generate_pages
        end

        def display
            display_items = []
            if !previous_pages.empty? && previous_pages.first != start_page && current_page != start_page
                display_items << start_page.to_s
            end

            if !previous_pages.empty? && previous_pages.first > start_page + 1
                display_items << '...'
            end

            previous_pages.each do |page|
                display_items << page.to_s
            end

            if number_of_pages > 0
              display_items << current_page.to_s
            end

            next_pages.each do |page|
                display_items << page.to_s
            end

            if !next_pages.empty? && next_pages.last != number_of_pages && next_pages.last + 1 != number_of_pages
                display_items << '...'
            end

            if !next_pages.empty? && next_pages.last != number_of_pages && current_page != number_of_pages
                display_items << number_of_pages.to_s
            end

            display_items.join(',').gsub(',...','...').gsub('...,','...')
        end

        private

        def generate_pages
            generate_previous_pages
            generate_next_pages
        end

        def generate_previous_pages
            @previous_pages = @calculator.previous_pages(current_page: current_page,
                                                         expected_returned: number_of_previous_pages)
        end

        def generate_next_pages
            @next_pages = @calculator.next_pages(current_page: current_page,
                                                 expected_returned: number_of_next_pages)
        end
    end
end
