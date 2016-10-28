class MmaCrawler
  # USES YAHOO SPORTS
  include Wombat::Crawler

  def initialize(date)
    @date = date
  end

  def crawl
    get_this_path = "/api/v1/us/events"
      base_url "http://ufc-data-api.ufc.com/"
      path get_this_path
      games "css=.wisbb_scheduleTable", :iterator do
        date "css=.time"
        # TO-DO GET RID OF JUNK ON TEAM1
        team1 "css=.away"
        team2 "css=.home"
      end
  end

end