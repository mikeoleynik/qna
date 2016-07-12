require 'rails_helper'

feature 'Delete question', '
  In order delete my question
  As user
  I want to destroy question' do

  let(:current_user) { create(:user) }
  let(:his_question) { create(:question, user: current_user) }
  let(:alien_question) { create(:question) }


  scenario 'auth user try to delete his question' do
    sign_in(current_user)
    visit question_path(his_question)
    click_on 'Удалить'

    expect(page).to have_content 'Your question deleted.'
    expect(page).to_not have_content his_question.title
  end

  scenario 'auth user can not delete alien question' do
    sign_in(current_user)
    visit question_path(alien_question)

    expect(page).to_not have_content 'Удалить'
  end

  scenario 'non auth user try to delete the question' do
    visit root_path

    expect(page).to_not have_content 'Delete question'
  end
end