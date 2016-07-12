require 'rails_helper'

feature 'User registration', %q{
  In order to be able to ask question
  As an User
  I want to be able to sign in
} do 

  let(:user) { create(:user) }

  scenario 'Non-registered user try to registered' do

    visit root_path
    click_on 'Регистрация'
    fill_in 'Email', with: 'noreply@test.com'
    fill_in 'Password', with: '12345678'
    fill_in 'Password confirmation', with: '12345678'
    click_on 'Sign up'

    expect(page).to have_content 'Welcome! You have signed up successfully.'
    expect(current_path).to eq root_path
  end

  scenario 'Registered user try to registered' do
    
    visit root_path
    click_on 'Регистрация'
    fill_in 'Email', with: user.email
    fill_in 'Password', with: user.password
    fill_in 'Password confirmation', with: user.password_confirmation
    click_on 'Sign up'

    expect(page).to have_content ' has already been taken'
  end

end