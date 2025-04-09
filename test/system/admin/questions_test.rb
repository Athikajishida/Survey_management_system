require "application_system_test_case"

class Admin::QuestionsTest < ApplicationSystemTestCase
  setup do
    @admin_question = admin_questions(:one)
  end

  test "visiting the index" do
    visit admin_questions_url
    assert_selector "h1", text: "Questions"
  end

  test "should create question" do
    visit admin_questions_url
    click_on "New question"

    click_on "Create Question"

    assert_text "Question was successfully created"
    click_on "Back"
  end

  test "should update Question" do
    visit admin_question_url(@admin_question)
    click_on "Edit this question", match: :first

    click_on "Update Question"

    assert_text "Question was successfully updated"
    click_on "Back"
  end

  test "should destroy Question" do
    visit admin_question_url(@admin_question)
    accept_confirm { click_on "Destroy this question", match: :first }

    assert_text "Question was successfully destroyed"
  end
end
