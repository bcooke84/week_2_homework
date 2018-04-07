require("minitest/autorun")
require("minitest/rg")

require_relative("../drink.rb")

class DrinkTest < MiniTest::Test
  def setup()
    @drink = Drink.new("Beer", 4.00, 10)
  end

def test_get_drink_name()
  assert_equal("Beer", @drink.name)
end

def test_get_drink_price()
  assert_equal(4.00, @drink.price)
end

def test_get_alcohol_leve()
  assert_equal(10, @drink.alcohol_level)
end

end
