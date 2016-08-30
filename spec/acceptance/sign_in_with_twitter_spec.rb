require_relative 'acceptance_helper'

feature 'Sign in with Twitter' do
  before { visit new_user_session_path }

  scenario 'user can sign in with his Twitter account' do
    expect(page).to have_content('Sign in with Twitter')

    mock_auth_hash(:twitter)
    OmniAuth.config.add_mock(:twitter, { info: { email: nil } }) 
    click_on 'Sign in with Twitter'
 
    expect(page).to have_content 'Пожалуйста введите свой e-mail'
    fill_in 'email', with: 'user_example@example.com'
    click_on 'Send'

    open_email('user_example@example.com')
    expect(current_email).to have_content "You can confirm your account email through the link below:"
    current_email.click_link 'Confirm my account'
    expect(page).to have_content 'Your email address has been successfully confirmed.'
    
    click_on 'Sign in with Twitter'
    expect(page).to have_content 'Successfully authenticated from Twitter account.'
  end

  scenario 'authentication error' do
    OmniAuth.config.mock_auth[:twitter] = :invalid_credentials
    click_on 'Sign in with Twitter'

    expect(page).to have_content 'Could not authenticate you from Twitter'
  end
end