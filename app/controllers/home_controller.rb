class HomeController < ApplicationController
  def index
    leaders = Pet.find_each.map do |p|
      {id: p.id, name: p.name, wins: p.wins}
    end
    leaders = leaders.sort {|left, right| right[:wins] <=> left[:wins]}.take 10
    render json: {leaders: leaders}
  end
end