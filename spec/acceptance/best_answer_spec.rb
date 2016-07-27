require_relative 'acceptance_helper'

feature 'Сhoose the best answer', %q{
  As user
  I want set best to one of answer
  In order to choose best answer
} do

  let!(:question) { create(:question) }

  # describe 'auth user' do

  # end

  describe 'Non auth user' do

    scenario 'not set best answer' do
      visit question_path(question)

      expect(page).to_not have_link 'Best answer'
    end
  end

end