require 'rails_helper'

feature 'Create answer' do

  let (:user) {create(:user)}
  let(:question) { create(:question, user: user) }
  
  scenario 'Authenticate user can write answer' do
    sign_in(user)
    
    visit question_path(question)
    fill_in 'Body', with:'Ответ'
    click_on 'Создать'

    expect(page).to have_content 'Ответ'
  end

  scenario 'Nonauthenticate user can not write answer' do
    visit question_path(question)
    fill_in 'Body', with:'Ответ'
    click_on 'Создать'

    expect(page).to have_content 'You need to sign in or sign up before continuing.'
  end
end