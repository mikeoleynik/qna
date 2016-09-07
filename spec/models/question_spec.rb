require 'rails_helper'

RSpec.describe Question, type: :model do
  it_behaves_like 'functional'
  
  it { should validate_presence_of :title }
  it { should validate_presence_of :body }
  it { should have_many(:answers).dependent(:destroy) }
end
