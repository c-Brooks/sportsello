class AddReferencesToReviews < ActiveRecord::Migration
  def change
    add_reference :reviews, :user, index: true, foreign_key: true
    add_reference :reviews, :venue, index: true, foreign_key: true
  end
end
