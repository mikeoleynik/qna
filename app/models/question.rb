class Question < ActiveRecord::Base
  include Attachable
  include Votable
  
  belongs_to :user
  has_many :answers, dependent: :destroy
  has_many :votes, as: :votable

  validates :title, :body, :user_id, presence: true

  def best_answer
    answers.where(best: true).first
  end
end
