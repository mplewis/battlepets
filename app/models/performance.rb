class Performance < ActiveRecord::Base
  belongs_to :pet
  belongs_to :match
end
