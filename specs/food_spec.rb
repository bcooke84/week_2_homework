require("minitest/autorun")
require("minitest/rg")

require_relative("../food.rb")

class FoodTest < MiniTest::Test
  def setup()
    @food = Food.new("Pizza", 10.00, -10)
  end

def test_get_food_name()
  assert_equal("Pizza", @food.name)
end

def test_get_food_price()
  assert_equal(10.00, @food.price)
end

def test_get_rejuvenation_leve()
  assert_equal(-10, @food.rejuvenation_level)
end

end
