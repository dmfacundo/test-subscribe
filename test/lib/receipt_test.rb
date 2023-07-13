require "minitest/autorun"
require "stringio"
require_relative "../../app/app.rb"

# inputs = [
# the first input is the category index
# the second input is the answer to the question "Is it imported? (Y/n)"
# the third input is the item description
# the fourth input is the answer to the question "Do you want to add another item? (Y/n)"
# ]

# So for example the first input is: "1\nn\n2 book at 12.49\n\n"
# 1 is the index of "Book" in the array of categories
# "n" is the answer to the question "Is it imported? (Y/n)"
# "2 book at 12.49" is the item description
# "\n" is the answer to the question "Do you want to add another item? (Y/n)"

class ReceiptTest < MiniTest::Test
  Kernel.send(:define_method, :puts) { |*args| "" } # this is to avoid printing to the console

  def test_input_1
    inputs = [
      "1\nn\n2 book at 12.49\n\n",
      "4\nn\n1 music CD at 14.99\n\n",
      "2\nn\n1 chocolate bar at 0.85\nn\n",
    ]
    $stdin = StringIO.new(inputs.join)
    receipt = Receipt.build
    assert_equal 1.50, receipt.taxes.to_f
    assert_equal 42.32, receipt.total.to_f
  end

  def test_input_2
    inputs = [
      "2\ny\n1 imported box of chocolates at 10.00\n\n",
      "4\ny\n1 imported bottle of perfume at 47.50\nn\n",
    ]
    $stdin = StringIO.new(inputs.join)
    receipt = Receipt.build
    assert_equal 7.65, receipt.taxes.to_f
    assert_equal 65.15, receipt.total.to_f
  end

  def test_input_3
    inputs = [
      "4\ny\n1 imported bottle of perfume at 27.99\n\n",
      "4\nn\n1 bottle of perfume at 18.99\n\n",
      "3\nn\n1 packet of headache pills at 9.75\n\n",
      "2\ny\n3 imported boxes of chocolates at 11.25\nn\n",
    ]
    $stdin = StringIO.new(inputs.join)
    receipt = Receipt.build
    assert_equal 7.90, receipt.taxes.to_f
    assert_equal 98.38, receipt.total.to_f
  end
end
