require_relative "./category"

class Item < Struct.new(:category, :imported, :quantity,
                        :name, :price, :tax, :subtotal)
  ROUND = 1 / 0.05

  def self.get(category, imported)
    puts "Enter the line item with the next format: <quantity> <item name> at <price with 2 decimals>"
    quantity, name, price = validate(gets.chomp.strip)
    result = new(category, imported, quantity.to_i, name, price.to_f)
    result.send(:calculate_tax)
    result.send(:calculate_subtotal)
    result
  end

  private

  def self.validate(item)
    args = item.match(/\A(\d)+ (.+) at (\d+(?:\.\d{2})?\z)/)
    return *args[1..3] if args

    puts "Invalid input. Please try again."
    validate(gets.chomp)
  end

  def calculate_tax
    if exempt?
      self[:tax] = 0
    else
      self[:tax] = round(price * 0.10) * self[:quantity]
    end
    self[:tax] += round(price * 0.05) * self[:quantity] if imported
    self[:tax] = self[:tax].round(2)
  end

  def calculate_subtotal
    self[:subtotal] = (self[:price] * self[:quantity] + self[:tax]).round(2)
  end

  def exempt? = Category.exempt?(category)

  def round(amount) = (amount * ROUND).ceil / ROUND
end
