class Question < ActiveRecord::Base
  has_many :answers, dependent: :destroy

  validates :title, :body, :user_id, presence: true
end
