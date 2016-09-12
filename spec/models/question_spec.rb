require 'rails_helper'

RSpec.describe Question, type: :model do
  it_behaves_like 'functional'
  
  it { should validate_presence_of :title }
  it { should validate_presence_of :body }
  it { should have_many(:answers).dependent(:destroy) }
  it { should have_many(:subscriptions).dependent(:destroy) }

  describe '#author_subscribe' do
    let(:user) { create(:user) }
    let(:question) { create(:question, user: user) }

    it 'subscribes author after create question' do
      expect(question.subscriptions.count).to eq 1
    end
  end
end
