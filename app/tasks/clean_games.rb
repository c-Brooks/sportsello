class CleanGames

  # Remove games older than x days
  def initialize
    Game.where("game_datetime < ?", 2.days.ago).destroy_all
  end

end
