require_relative "./lib/item"
require_relative "./lib/receipt"

class App
  def self.run
    receipt = Receipt.build
    receipt.print
    receipt
  end
end
