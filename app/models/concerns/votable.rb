module Votable
  extend ActiveSupport::Concern

    included do
      has_many :votes, as: :votable
    end

    def count_votes
      votes.sum(:rating)
    end
end