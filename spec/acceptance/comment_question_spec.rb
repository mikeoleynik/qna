require_relative 'acceptance_helper'

  feature 'Add comment to question' do

    let(:user) {create(:user)}
    let!(:question) {create(:question)}

    before do
      sign_in(user)
      visit question_path(question)
    end

    scenario "User can add comment to question", js: true do
      within ".question" do
      click_on "Add comment"
      fill_in "Comment", with: "I'am can create comment to question!"
      click_on 'Create'
      expect(page).to have_content "I'am can create comment to question!"
      end
    end
  end