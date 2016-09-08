require 'rails_helper'

RSpec.describe Authorization do
    it_behaves_like 'userable'
    
    it { should validate_presence_of :user_id}
    it { should validate_presence_of :provider}
    it { should validate_presence_of :uid}
end