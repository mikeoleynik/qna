require 'rails_helper'

feature 'Delete question', '
  In order delete my question
  As user
  I want to destroy question' do

  let(:current_user) { create(:user) }
  let(:my_question) { create(:question, user: current_user) }
  let(:alien_question) { create(:question) }


  scenario 'auth user try to delete his question' do
    sign_in(current_user)
    visit question_path(my_question)
    click_on 'Удалить'

    expect(page).to_not have_content my_question.title
  end

  scenario 'auth user can not delete alien question' do
    sign_in(current_user)
    visit root_path

    expect(page).to_not have_content 'Удалить'
  end

  scenario 'non auth user try to delete the question' do
    visit root_path

    expect(page).to_not have_content 'Удалить'
  end
end