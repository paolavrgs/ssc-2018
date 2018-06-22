require "application_system_test_case"

class CensusTest < ApplicationSystemTestCase
  setup do
    @censu = census(:one)
  end

  test "visiting the index" do
    visit census_url
    assert_selector "h1", text: "Census"
  end

  test "creating a Censu" do
    visit census_url
    click_on "New Censu"

    fill_in "Birthdate", with: @censu.birthdate
    fill_in "Calle", with: @censu.calle
    fill_in "Casa", with: @censu.casa
    fill_in "Edad", with: @censu.edad
    fill_in "Last Name", with: @censu.last_name
    fill_in "Name", with: @censu.name
    fill_in "Nivel Estudio", with: @censu.nivel_estudio
    fill_in "Piso", with: @censu.piso
    fill_in "Position", with: @censu.position
    fill_in "Profesion", with: @censu.profesion
    fill_in "Sector", with: @censu.sector
    click_on "Create Censu"

    assert_text "Censu was successfully created"
    click_on "Back"
  end

  test "updating a Censu" do
    visit census_url
    click_on "Edit", match: :first

    fill_in "Birthdate", with: @censu.birthdate
    fill_in "Calle", with: @censu.calle
    fill_in "Casa", with: @censu.casa
    fill_in "Edad", with: @censu.edad
    fill_in "Last Name", with: @censu.last_name
    fill_in "Name", with: @censu.name
    fill_in "Nivel Estudio", with: @censu.nivel_estudio
    fill_in "Piso", with: @censu.piso
    fill_in "Position", with: @censu.position
    fill_in "Profesion", with: @censu.profesion
    fill_in "Sector", with: @censu.sector
    click_on "Update Censu"

    assert_text "Censu was successfully updated"
    click_on "Back"
  end

  test "destroying a Censu" do
    visit census_url
    page.accept_confirm do
      click_on "Destroy", match: :first
    end

    assert_text "Censu was successfully destroyed"
  end
end
