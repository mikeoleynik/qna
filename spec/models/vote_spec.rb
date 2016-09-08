require 'rails_helper'

describe Vote do
  it_behaves_like 'userable'
  
  it { should belong_to :votable}
end