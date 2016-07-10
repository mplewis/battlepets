class Match < ActiveRecord::Base
  has_many :performances

  def winner
    performances.order(score: :desc).first
  end
end
