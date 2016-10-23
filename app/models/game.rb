class Game < ActiveRecord::Base
  belongs_to :sport

  validates :game_datetime, presence: true
  validates :team1_id, numericality: { only_integer: true }
  validates :team2_id, numericality: { only_integer: true }

  private

  def event_datetime_is_date?
     if !event_datetime.is_a?(DateTime)
      puts(:event_datetime)
       errors.add(:event_datetime, 'must be a valid date')
     end
  end

end
