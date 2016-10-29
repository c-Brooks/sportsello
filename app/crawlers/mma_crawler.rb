class MmaCrawler
  # USES YAHOO SPORTS
  include Wombat::Crawler


  def crawl

    Wombat.crawl do
      base_url "http://m.ufc.ca/schedule/"
      # path get_this_path
        games "css=.schedule li", :iterator do
          date "css=a"
          time "css=a"
          team1 "css=a > strong"
          team2 "css=a > strong"

      end
    end

  end

end