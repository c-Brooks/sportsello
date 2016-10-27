class NflCrawler
  # USES YAHOO SPORTS
  include Wombat::Crawler

  def initialize(date)
    @date = date
  end

  def crawl
    get_this_path = "/Sports/NFL/Matchups?selectedDate=#{@date}"

    Wombat.crawl do
      base_url "http://www.covers.com/"
      path get_this_path
      # top_date = "css=.cmb_matchup_game > .cmb_matchup_game_box > .cmb_matchup_header_date"
      # date_comp = Date(top_date.split(',')[1])
      games "css=.cmg_matchup_game", :iterator do
        date "css=.cmg_matchup_game_box", :iterator do
          actual_date "xpath=./@data-game-date"
        end
        team1 "css=.cmg_matchup_header_team_names"
        team2 "css=.cmg_matchup_header_team_names"
       end
    end
  end

end