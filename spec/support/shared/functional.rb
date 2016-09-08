shared_examples_for 'functional' do
  it { should have_many :attachments }
  it { should have_many :votes }
  it { should have_many :comments }
end