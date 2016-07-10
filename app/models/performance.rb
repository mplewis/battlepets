class Performance < ActiveRecord::Base
  belongs_to :pet
  belongs_to :match

  def winning?
    match.winner == self
  end
end
