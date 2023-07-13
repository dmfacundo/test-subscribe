require_relative "./item"
require_relative "./category"

class Receipt < Struct.new(:items, :taxes, :total)
  def self.build
    items = []
    loop do
      category = Category.get
      items << Item.get(category.name, category.imported)
      puts "Do you want to add more items? (Y/n)"
      add_more = gets.chomp != "n"
      break unless add_more
    end
    result = new(items)
    result.send(:calculate_taxes)
    result.send(:calculate_total)
    result
  end

  def print
    items.each do |item|
      puts "#{item.quantity} #{item.name}: #{item.subtotal}"
    end
    puts "Sales Taxes: #{taxes}"
    puts "Total: #{total}"
  end

  private

  def calculate_taxes
    amount = items.sum { |item| item.tax }.round(2)
    self[:taxes] = sprintf("%0.02f", amount)
  end

  def calculate_total
    amount = items.sum { |item| item.subtotal }.round(2)
    self[:total] = sprintf("%0.02f", amount)
  end
end
