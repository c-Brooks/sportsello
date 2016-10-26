class CleanGames

  def initialize
    # Remove games older than x days
    @days_ago = 2.days.ago
  end

  def clean
    Game.where("game_datetime < ?", @days_ago).destroy_all
  end

end
