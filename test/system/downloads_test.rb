require "application_system_test_case"

class DownloadsTest < ApplicationSystemTestCase
  setup do
    @download = downloads(:one)
  end

  test "visiting the index" do
    visit downloads_url
    assert_selector "h1", text: "Downloads"
  end

  test "creating a Download" do
    visit downloads_url
    click_on "New Download"

    fill_in "Description", with: @download.description
    fill_in "File", with: @download.file
    fill_in "Position", with: @download.position
    fill_in "Title", with: @download.title
    click_on "Create Download"

    assert_text "Download was successfully created"
    click_on "Back"
  end

  test "updating a Download" do
    visit downloads_url
    click_on "Edit", match: :first

    fill_in "Description", with: @download.description
    fill_in "File", with: @download.file
    fill_in "Position", with: @download.position
    fill_in "Title", with: @download.title
    click_on "Update Download"

    assert_text "Download was successfully updated"
    click_on "Back"
  end

  test "destroying a Download" do
    visit downloads_url
    page.accept_confirm do
      click_on "Destroy", match: :first
    end

    assert_text "Download was successfully destroyed"
  end
end
