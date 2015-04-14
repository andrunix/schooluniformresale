require 'test_helper'

class CategoryTest < ActiveSupport::TestCase
  test "save_with_description" do
    cat = Category.new(name: "", description: "This is ugly")
    assert_not cat.save

    cat.name = "Ugly"
    assert cat.save
  end
end
