require 'rails_helper'

RSpec.describe Answer, type: :model do
  it_behaves_like 'functional'

  it { should validate_presence_of :body }
  it { should belong_to :question }
  it { should validate_presence_of :question_id }
  it { should have_db_index :question_id }

  it { should accept_nested_attributes_for :attachments }
end
