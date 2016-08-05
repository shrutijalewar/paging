require 'test_helper'

describe Paging::Calculator do
  before do
    @test_array = Paging::Calculator.new(number_of_pages: 50)
    @wanted_previous_pages = 5
    @number_of_next = 5
  end

  describe "has methods we need" do
    it 'has previous_pages method' do
      #previous_pages(current_page,expected_returned,min_page)
      assert_respond_to @test_array, :previous_pages
    end

    it "has next_pages method" do
      #next_pages(current_page,expected_returned, max_page)
      assert_respond_to @test_array, :next_pages
    end
  end

  describe "previous pages" do
    it "doesn't go past min index" do
      current_page = 3
      min_page = 1
      assert_equal [1, 2], @test_array.previous_pages(current_page: current_page, expected_returned: @wanted_previous_pages, min_page: min_page)
    end

    it "returns the right size based on default min_index" do
      current_page = 5
      assert_equal 4, @test_array.previous_pages(current_page: current_page, expected_returned: @wanted_previous_pages).size
    end

    it "returns the full number of pages we expect" do
      current_page = 30
      assert_equal [25, 26, 27, 28, 29], @test_array.previous_pages(current_page: current_page, expected_returned: @wanted_previous_pages)
    end

    it "returns empty array if on first page" do
      current_page = 1
      assert_equal [], @test_array.previous_pages(current_page: current_page, expected_returned: @wanted_previous_pages)
    end

    it "returns prev page [1] if on page 2" do
      current_page = 2
      assert_equal [1], @test_array.previous_pages(current_page: current_page, expected_returned: @wanted_previous_pages)
    end

    it "returns empty error from garage in" do
      current_page = -10
      assert_equal [], @test_array.previous_pages(current_page: current_page, expected_returned: @wanted_previous_pages)
    end
  end

  describe "next pages" do
    it "doesn't go past max index" do
      current_page = 48
      max_page = 50
      assert_equal [49, 50], @test_array.next_pages(current_page: current_page, expected_returned: @number_of_next, max_page: max_page)
    end

    it "returns the right size based on default max_index" do
      current_page = 46
      assert_equal 4, @test_array.next_pages(current_page: current_page,expected_returned:  @number_of_next).size
    end

    it "returns the full number of pages we expect" do
      current_page = 30
      assert_equal [31, 32, 33, 34, 35], @test_array.next_pages(current_page: current_page,expected_returned: @number_of_next)
    end

    it "returns empty array if on last page" do
      current_page = 50
      assert_equal [], @test_array.next_pages(current_page: current_page, expected_returned: @number_of_next)
    end

    it "return next page [50] if on page 49" do
      current_page = 49
      assert_equal [50], @test_array.next_pages(current_page: current_page, expected_returned: @number_of_next)
    end

    it "returns empty error from garage in" do
      current_page = 99999
      assert_equal [], @test_array.next_pages(current_page: current_page, expected_returned: @number_of_next)
    end
  end

end
