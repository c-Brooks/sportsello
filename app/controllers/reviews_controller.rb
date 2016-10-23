class ReviewsController < ApplicationController
    def create
      @venue = Venue.find(params["venue_id"])
      @review = Review.new(review_params)
      @review.user_id = session[:user_id]
    if @review.save
      redirect_to :back
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
      params.require(:review).permit(:rating, :description, :venue_id)
    end
end
