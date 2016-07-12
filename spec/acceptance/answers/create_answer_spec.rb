require 'rails_helper'

feature 'Create answer' do

  let (:user) {create(:user)}
  
  scenario 'Authenticate user can write answer' do
    sign_in(user)
    
    visit questions_path
    click_on 'Показать'
    fill_in 'Body', with:'Ответ'
    click_on 'Создать'

    expect(page).to have_content 'it is my answer'
  end

  scenario 'Nonauthenticate user can not write answer' do
    visit questions_path
    click_on 'Показать'
    fill_in 'Body', with:'Ответ'
    click_on 'Создать'

    expect(page).to have_content 'You need to sign in or sign up before continuing.'
  end
end