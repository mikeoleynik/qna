require 'rails_helper'

RSpec.describe Comment, type: :model do
  it_behaves_like 'userable'
  
  it { should belong_to :commentable }
end