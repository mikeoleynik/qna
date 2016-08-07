require_relative 'acceptance_helper'

feature 'Add files to answer', %q{
  In order to illustrate my answer
  As an answer's author
  I'd like to be able to attach files
} do

  let(:user){ create(:user) }
  let(:another_user){create(:user)}
  let!(:question){ create(:question) }

  before do
    sign_in(user)
    visit question_path(question)
    fill_in 'Ответ', with: 'text body answer'
  end

  scenario 'User adds file when answer', js: true do
    click_on 'Добавить'
    all('input[type="file"]')[0].set("#{Rails.root}/spec/spec_helper.rb")
    click_on 'Добавить'
    all('input[type="file"]')[1].set("#{Rails.root}/spec/rails_helper.rb")
    click_on 'Создать'

    within '.answers' do
      expect(page).to have_link 'spec_helper.rb', href: '/uploads/attachment/file/1/spec_helper.rb'
      expect(page).to have_link 'rails_helper.rb', href: '/uploads/attachment/file/2/rails_helper.rb'
    end
  end

  scenario 'Author can delete their attached files', js: true do
    attach_file 'File', "#{Rails.root}/spec/spec_helper.rb"  
    click_on "Создать"
    
    within ".answers" do
      click_on "удалитьфайл"
      expect(page).to_not have_content "spec_helper.rb"
    end
  end

  scenario "Only author can destroy their files", js: true do
    attach_file 'File', "#{Rails.root}/spec/spec_helper.rb"  
    click_on "Создать"
    expect(page).to have_content "удалитьфайл"

    click_on "Выход"
    
    sign_in(another_user)   
    visit question_path(question)
    within ".answers" do
      expect(page).to_not have_content "удалитьфайл"
    end
  end

end