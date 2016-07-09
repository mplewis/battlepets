class Pet < ActiveRecord::Base
  has_many :performances
end
