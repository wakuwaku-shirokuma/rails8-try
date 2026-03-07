require "test_helper"

class CompanyTest < ActiveSupport::TestCase
  test "should not save company without name" do
    company = Company.new
    assert_not company.save, "Saved the company without a name"
  end

  test "should save company with name" do
    company = Company.new(name: "Test Company")
    assert company.save, "Could not save the company with a name"
  end
end
