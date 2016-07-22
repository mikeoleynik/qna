require_relative 'acceptance_helper'

feature 'Create answer', %q{
 In order to answer the questions
 As an authenticated user
} do

  let(:user) {create(:user)}
  let(:question) { create(:question, user: user) }
  
  scenario 'Authenticate user can ask', js: true do
    sign_in(user)
    
    visit question_path(question)
    fill_in 'Просто добавь ответ:', with:'ТекстОтвета'
    click_on 'Создать'
    
    within '.answers' do
      expect(page).to have_content 'ТекстОтвета'
    end
  end

  scenario 'Nonauthenticate user can not ask' do
    visit question_path(question)
    fill_in 'Просто добавь ответ:', with:'ТекстОтвета'
    click_on 'Создать'

    expect(page).to have_content 'You need to sign in or sign up before continuing.'
  end

  scenario 'User try to create invalid answer', js: true do
    sign_in(user)

    visit question_path(question)
    click_on 'Создать'

    expect(page).to have_content "can't be blank"
  end
end