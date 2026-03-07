require "application_system_test_case"

class CompaniesTest < ApplicationSystemTestCase
  setup do
    @company = companies(:one)
  end

  test "visiting the index" do
    visit companies_url
    assert_selector "h1", text: "Companies"
  end

  test "should create company" do
    visit companies_url
    click_on "New company"

    fill_in "Name", with: "New Company"
    fill_in "Description", with: "New company description"
    click_on "Create Company"

    assert_text "Company was successfully created"
  end

  test "should update company" do
    visit company_url(@company)
    click_on "Edit"

    fill_in "Name", with: "Updated Company"
    click_on "Update Company"

    assert_text "Company was successfully updated"
  end

  test "should destroy company" do
    visit companies_url
    assert_text @company.name

    accept_confirm do
      click_on "Destroy", match: :first
    end

    assert_text "Company was successfully destroyed"
  end
end
