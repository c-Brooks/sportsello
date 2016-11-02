class ReviewsController < ApplicationController
    def create
      @venue = Venue.find(params["venue_id"])
      @review = Review.new(review_params)
    if @review.save
      render json: @review
    else
      puts @review.errors.to_a
    end
  end

  def destroy
    @review = Review.find params[:id]
    @review.destroy
    redirect_to :back, notice: 'Review deleted!'
  end

  private
    def review_params
      params.permit(:user_id, :rating, :description, :venue_id)
    end
end
