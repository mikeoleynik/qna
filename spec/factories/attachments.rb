include ActionDispatch::TestProcess

FactoryGirl.define do
  factory :attachment do
    file { fixture_file_upload("#{Rails.root}/spec/rails_helper.rb") }
  end
end
