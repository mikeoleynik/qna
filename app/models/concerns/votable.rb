module Votable
  extend ActiveSupport::Concern

    def count_votes
      votes.sum(:rating)
    end

    def vote_it(rating, user)
      votes.create(rating: rating, user: user)
    end

    def vote_empty?(user)
      Vote.exists?(user: user)
    end
end
