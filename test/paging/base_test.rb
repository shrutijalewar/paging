require 'test_helper'

describe Paging::Base do

  describe "takes minimum arguments current_page and number_of_pages" do
    before do
      @base = Paging::Base.new(current_page: 10, number_of_pages: 50)
    end

    it 'sets current_page' do
      assert_equal 10, @base.current_page
    end

    it 'sets number_of_pages' do
      assert_equal 50, @base.number_of_pages
    end

    it 'sets number_of_previous_pages' do
      assert_equal 5, @base.number_of_next_pages
    end

    it 'sets number_of_previous_pages' do
      assert_equal 5, @base.number_of_next_pages
    end

    it 'sets start_page' do
      assert_equal 1, @base.start_page
    end

    it 'sets previous_pages' do
      assert_equal [5,6,7,8,9], @base.previous_pages
    end

    it 'sets next_pages' do
      assert_equal [11,12,13,14,15], @base.next_pages
    end
  end

  describe 'takes custom number_of_previous_pages' do
    before :each do
      @base = Paging::Base.new(current_page: 15,
                                  number_of_pages: 50,
                                  number_of_previous_pages: 10)
    end

    it "sets previous_pages to a previous 10 pages back from page 15" do
      assert_equal [5,6,7,8,9,10,11,12,13,14],  @base.previous_pages
    end
  end

  describe 'takes custom number_of_next_pages' do
    before :each do
      @base = Paging::Base.new(current_page: 15,
                                  number_of_pages: 50,
                                  number_of_next_pages: 10)
    end

    it "sets previous_pages to a previous 10 pages back from page 15" do
      assert_equal [16,17,18,19,20,21,22,23,24,25], @base.next_pages
    end
  end

  describe "display method shows what pagination might look like" do
    it "handles first page" do
      base = Paging::Base.new(current_page: 1,
                                  number_of_pages: 50,
                                  number_of_previous_pages: 3,
                                  number_of_next_pages: 3)
      assert_equal "1,2,3,4...50", base.display
    end

    it "handles page 15" do
      base = Paging::Base.new(current_page: 15,
                                  number_of_pages: 50,
                                  number_of_previous_pages: 3,
                                  number_of_next_pages: 3)
      assert_equal "1...12,13,14,15,16,17,18...50", base.display
    end

    it "handles small amount of pages" do
      base = Paging::Base.new(current_page: 1,
                                  number_of_pages: 5,
                                  number_of_previous_pages: 3,
                                  number_of_next_pages: 3)
      assert_equal "1,2,3,4,5", base.display
    end

    it "handles one page" do
      base = Paging::Base.new(current_page: 1,
                                  number_of_pages: 1,
                                  number_of_previous_pages: 3,
                                  number_of_next_pages: 3)
      assert_equal "1", base.display
    end

    it "handles being exactly in the middle" do
      base = Paging::Base.new(current_page: 4,
                                  number_of_pages: 7,
                                  number_of_previous_pages: 3,
                                  number_of_next_pages: 3)
      assert_equal "1,2,3,4,5,6,7", base.display
    end

    it "handles only having more" do
      base = Paging::Base.new(current_page: 2,
                                  number_of_pages: 7,
                                  number_of_previous_pages: 3,
                                  number_of_next_pages: 3)
      assert_equal "1,2,3,4,5...7", base.display
    end

    it "handles only have less" do
      base = Paging::Base.new(current_page: 7,
                                  number_of_pages: 7,
                                  number_of_previous_pages: 3,
                                  number_of_next_pages: 3)
      assert_equal "1...4,5,6,7", base.display
    end

    it "handles no pages" do
      base = Paging::Base.new(current_page: 1,
                                  number_of_pages: 0,
                                  number_of_previous_pages: 3,
                                  number_of_next_pages: 3)
      puts base.previous_pages
      assert_equal "", base.display
    end

  end

end
