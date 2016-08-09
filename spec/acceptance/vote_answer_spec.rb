require_relative 'acceptance_helper'

feature 'Vote answer', %q{
  In order to mark answers
  As an authenticated user
  I want to be able to vote for answers
} do

  let(:user) { create(:user) }
  let!(:question) { create(:question) }
  let!(:user_answer) { create(:answer, user: user, question: question) }
  let!(:answer) { create(:answer, question: question) }

  describe 'Auth user', js: true do
    before { sign_in(user) }

    scenario 'votes up for answer' do
      visit question_path(question)
      within(".answer_#{answer.id}") do
        click_on '+'

        within('.rating') do
          expect(page).to have_content '1'
        end
      end 
    end

    scenario 'votes down for answer', js: true do
      visit question_path(question)
      within(".answer_#{answer.id}") do
        click_on '+'

        within('.rating') do
          expect(page).to have_content '-1'
        end
      end 
    end
  end

  describe 'Non auth user', js: true do

    scenario 'cant see vote buttons' do
      visit question_path(question)

      expect(page).to_not have_content '+'
    end
  end

end