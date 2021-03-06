require_relative 'acceptance_helper'

feature 'Delete answer', %q{
 In order delete my answer
 As user
 I want to destroy answer
} do

  let(:current_user) { create(:user) }
  let(:his_question) { create(:question, user: current_user) }
  let(:alien_question) { create(:question) }
  let(:question) { create(:question) }
  let!(:his_answer) { create(:answer, question: his_question, user: current_user) }
  let(:alien_answer) { create(:answer, question: alien_question) }

  scenario 'auth user delete his answer', js: true do
    sign_in(current_user)
    visit question_path(his_question)

    click_on 'УдалитьОтвет'

    expect(page).to_not have_content his_answer.body
    expect(current_path).to eq question_path(his_question)
  end

  scenario 'auth user can not delete alien answer' do
    sign_in(current_user)
    visit question_path(alien_question)
 
    expect(page).to_not have_content 'Удалить'
  end

  scenario 'non-auth user try to delete the answer' do
    visit question_path(question)

    expect(page).to_not have_content 'Удалить'
  end
end