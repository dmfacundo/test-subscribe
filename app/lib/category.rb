class Category < Struct.new(:name, :imported)
  CATEGORIES = ["Book", "Food", "Medical", "Other"]

  def self.exempt?(name) = CATEGORIES[0..2].include?(name)

  def self.get
    puts "Please enter the item category:"
    CATEGORIES.each_with_index do |category, index|
      puts "#{index + 1}. #{category}"
    end
    input = validate(gets.chomp.strip)
    puts "Is it imported? (Y/n)"
    imported = gets.chomp != "n"
    new(CATEGORIES[input.to_i - 1], imported)
  end

  private

  def self.validate(input)
    return input if input.to_i.between?(1, CATEGORIES.size)

    puts "Invalid input. Please try again."
    validate(gets.chomp)
  end
end
