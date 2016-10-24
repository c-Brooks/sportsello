class GamesController < ApplicationController
  def index
    @games = Game.paginate(page: params[:page], per_page: 15).order('created_at DESC')
    respond_to do |format|
      format.html
      format.js
    end
  end
end
