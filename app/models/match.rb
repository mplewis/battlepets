class Match < ActiveRecord::Base
  has_many :performances

  def winner
    performances.order(score: :desc).first
  end

  def complete
    performances.where(complete: false).count == 0
  end
end
