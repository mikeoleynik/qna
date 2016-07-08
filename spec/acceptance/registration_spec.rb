require 'rails_helper'

feature 'User sign in', %q{
  In order to be able to ask question
  As an User
  I want to be able to sign in
} do 

  let(:user) { create(:user) }

  # scenario 'Registered user try to sign in' do
  #   sign_in(user)

  #   expect(page).to have_content 'Signed in successfully.'
  #   expect(current_path).to eq root_path
  # end

  scenario 'Non-registered user try to registered' do

    visit root_path
    click_on 'Регистрация'
    fill_in 'Email', with: 'noreply@test.com'
    fill_in 'Password', with: '12345678'
    fill_in 'Password confirmation', with: '12345678'
    click_on 'Sign up'

    expect(page).to have_content 'Добро пожаловать! Вы успешно зарегистрировались.'
    expect(current_path).to eq root_path
  end

  scenario 'Registered user try to registered' do
    
    visit root_path
    click_on 'Регистрация'
    fill_in 'Email', with: user.email
    fill_in 'Password', with: user.password
    fill_in 'Password confirmation', with: user.password
    click_on 'Sign up'

    expect(page).to have_content 'Вы уже вошли в систему.'
    expect(current_path).to eq root_path
  end

end