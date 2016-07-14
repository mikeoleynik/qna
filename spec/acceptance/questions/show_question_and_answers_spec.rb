require 'rails_helper'

feature 'View the question and answer', '
  User want to view the question and answers' do
  let(:user) { create(:user) }
  let(:question) { create(:question) }
  let(:answers) { create_list(:answer, 2, question: question, user: user) }

  scenario 'User view the question and answers' do
    visit question_path(question)

    expect(page).to have_content question.title
    expect(page).to have_content question.body
    answers.each do |answer|
      expect(page).to have_content answer.body
    end
  end
end