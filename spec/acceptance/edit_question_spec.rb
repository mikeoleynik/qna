require_relative 'acceptance_helper'

feature 'Edit question', '
  In order edit my question
  As user
  I want to edit question' do

  let!(:current_user) { create(:user) }
  let!(:user) { create(:user) }
  let!(:his_question) { create(:question, user: current_user) }
  let!(:question) { create(:question) }

  scenario 'auth user see edit link his question' do
    sign_in(current_user)
    visit question_path(his_question)

    expect(page).to have_content 'Редактировать'
  end

  scenario 'auth user not see edit link alien question' do
    sign_in(user)
    visit question_path(question)

    expect(page).to_not have_content 'Редактировать'
  end

  scenario 'auth user try to edit his question', js: true do
    sign_in(current_user)
    visit question_path(his_question)
    click_on 'Редактировать'

    fill_in 'Заголовок', with: 'title10test'
    fill_in 'Ваш вопрос', with: 'text text text'
    click_on 'Save'

    expect(page).to have_content 'title10test'
    expect(page).to have_content 'text text text'
  end
end