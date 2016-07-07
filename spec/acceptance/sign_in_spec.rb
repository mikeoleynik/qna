require 'rails_helper'

feature 'User sign in', %q{
  In order to be able to ask question
  As an User
  I want to be able to sign in
} do 

  scenario 'Registered user try to sign in' do
    User.create!(email: 'user@test.com', password: '12345678')

    visit new_user_session_path
    fill_in 'Email', with: 'user@test.com'
    fill_in 'Password', with: '12345678'
    click_on 'Log in'

    expect(page).to have_content 'Signed in successfully.'
    expect(current_path).to eq root_path
  end

  scenario 'Non-registered user try to sign in' do

    visit new_user_session_path
    fill_in 'Email', with: 'noreply@test.com'
    fill_in 'Password', with: '12345678'
    click_on 'Log in'

    expect(page).to have_content 'QnaLink 1Link 2Link 3Invalid Email or password.×Invalid Email or password.Log in Email Password Remember me Sign up Forgot your password? SidebarSidebarLink 1Link 2Link 3© Company 2016'
    expect(current_path).to eq new_user_session_path
  end

end