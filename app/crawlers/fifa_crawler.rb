class FifaCrawler
  # USES YAHOO SPORTS
  include Wombat::Crawler

  def initialize(date)
    @date = date
  end

  def crawl
    get_this_path = "/international-friendly/53/scores?date=#{@date}" #20161106

    Wombat.crawl do
      base_url "http://www.espnfc.us/"
      path get_this_path
      games "css=.scores > .score-box > .score > .scorebox-container > .score-content", :iterator do
        date "css=.game-info > span", :iterator do
           date_time "xpath=./@data-time"
        end
        teams "css=.team-names > .team-name", :iterator do
           team "css=span"
        end
        # team1 "css=team-names"
        # team2 "css=team-names"
      end
    end
  end

end
