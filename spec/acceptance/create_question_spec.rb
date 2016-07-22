require_relative 'acceptance_helper'

feature 'Create question', %q{
  In order to get answer from community
  As an authenticated user
  I want to be able to ask questions
} do 

  let(:user) { create(:user) }

  scenario 'Authenticated user creates question' do
    sign_in(user)

    visit questions_path
    click_on 'Создать вопрос'
    fill_in 'Заголовок', with: 'Test question'
    fill_in 'Вопрос', with: 'text'
    click_on 'Создать'

    expect(page).to have_content 'Test question'
    expect(page).to have_content 'text'
  end

  scenario 'Non-auth user ties to create question' do
    visit questions_path
    click_on 'Создать'

    expect(page).to have_content 'You need to sign in or sign up before continuing.'
  end

end