require "minitest/autorun"
require "stringio"
require_relative "../../app/lib/item.rb"

class ItemTest < MiniTest::Test
  Kernel.send(:define_method, :puts) { |*args| "" } # this is to avoid printing to the console

  def test_should_instantiate_exempt_item
    $stdin = StringIO.new("1 book at 12.49\n")
    item = Item.get("Book", false)
    assert_equal "book", item.name
    assert_equal 1, item.quantity
    assert_equal 12.49, item.price
    assert_equal 0, item.tax
    assert_equal 12.49, item.subtotal
  end

  def test_should_instantiate_non_exempt_item
    $stdin = StringIO.new("1 music CD at 14.99\n")
    item = Item.get("Other", false)
    assert_equal "music CD", item.name
    assert_equal 1, item.quantity
    assert_equal 14.99, item.price
    assert_equal 1.50, item.tax
    assert_equal 16.49, item.subtotal
  end

  def test_should_not_instantiate_non_valid_name
    # "1 book 12.49" is not a valid input
    # so the user will be asked to input again
    # "1 book at 12.49" is a valid input
    # and the item will be instantiated

    $stdin = StringIO.new("1 book 12.49\n1 music CD at 12.49\n")
    item = Item.get("Other", false)
    assert_equal "music CD", item.name
  end

  def test_should_not_instantiate_non_valid_quantity
    # "One book at 12.49" is not a valid input
    # so the user will be asked to input again
    # "1 book at 12.49" is a valid input
    # and the item will be instantiated

    $stdin = StringIO.new("One book at 12.49\n1 music CD at 12.49\n")
    item = Item.get("Other", false)
    assert_equal 1, item.quantity
  end

  def test_should_not_instantiate_non_valid_price
    # "1 book at some price" is not a valid input
    # so the user will be asked to input again
    # "1 book at 12.49" is a valid input
    # and the item will be instantiated

    $stdin = StringIO.new("1 book at some price\n1 music CD at 12.49\n")
    item = Item.get("Other", false)
    assert_equal 12.49, item.price
  end
end
