require "application_system_test_case"

class Admin::SurveysTest < ApplicationSystemTestCase
  setup do
    @admin_survey = admin_surveys(:one)
  end

  test "visiting the index" do
    visit admin_surveys_url
    assert_selector "h1", text: "Surveys"
  end

  test "should create survey" do
    visit admin_surveys_url
    click_on "New survey"

    click_on "Create Survey"

    assert_text "Survey was successfully created"
    click_on "Back"
  end

  test "should update Survey" do
    visit admin_survey_url(@admin_survey)
    click_on "Edit this survey", match: :first

    click_on "Update Survey"

    assert_text "Survey was successfully updated"
    click_on "Back"
  end

  test "should destroy Survey" do
    visit admin_survey_url(@admin_survey)
    accept_confirm { click_on "Destroy this survey", match: :first }

    assert_text "Survey was successfully destroyed"
  end
end
