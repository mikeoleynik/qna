class Question < ActiveRecord::Base
  include Attachable
  include Votable
  include Commentable
  
  belongs_to :user
  has_many :answers, dependent: :destroy
  has_many :votes, as: :votable
  has_many :subscriptions, dependent: :destroy

  validates :title, :body, :user_id, presence: true

  after_create :author_subscribe

  scope :created_for_day, -> { where(created_at: 1.day.ago..Time.zone.now) }

  def best_answer
    answers.where(best: true).first
  end

  private

  def author_subscribe
    subscriptions.create(user: user)
  end
end
