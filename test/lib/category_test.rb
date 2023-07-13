require "minitest/autorun"
require "stringio"
require_relative "../../app/lib/category.rb"

class CategoryTest < MiniTest::Test
  Kernel.send(:define_method, :puts) { |*args| "" } # this is to avoid printing to the console

  def test_should_instantiate_category
    # 2 is the index of "Food" in the array of categories
    # "y" is the input for the question "Is it imported? (Y/n)"
    $stdin = StringIO.new("2\ny\n")
    category = Category.get
    assert_equal "Food", category.name
  end

  def test_should_return_true_if_category_is_exempt
    assert_equal true, Category.exempt?("Book")
  end

  def test_should_return_false_if_category_is_not_exempt
    assert_equal false, Category.exempt?("Other")
  end

  def test_should_return_false_if_category_is_not_valid
    assert_equal false, Category.exempt?("Invalid")
  end
end
