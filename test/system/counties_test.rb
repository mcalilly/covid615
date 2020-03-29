require "application_system_test_case"

class CountiesTest < ApplicationSystemTestCase
  setup do
    @county = counties(:one)
  end

  test "visiting the index" do
    visit counties_url
    assert_selector "h1", text: "Counties"
  end

  test "creating a County" do
    visit counties_url
    click_on "New County"

    fill_in "Fips", with: @county.fips
    fill_in "Name", with: @county.name
    fill_in "State", with: @county.state_id
    click_on "Create County"

    assert_text "County was successfully created"
    click_on "Back"
  end

  test "updating a County" do
    visit counties_url
    click_on "Edit", match: :first

    fill_in "Fips", with: @county.fips
    fill_in "Name", with: @county.name
    fill_in "State", with: @county.state_id
    click_on "Update County"

    assert_text "County was successfully updated"
    click_on "Back"
  end

  test "destroying a County" do
    visit counties_url
    page.accept_confirm do
      click_on "Destroy", match: :first
    end

    assert_text "County was successfully destroyed"
  end
end
