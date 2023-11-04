class BlockersController < ApplicationController
  def index
    blockers = Blockers.all
    render json: blockers
  end

  def create
    blocker = Blocker.create(blocker_params)
  end

  private
  def blocker_params
    params.require(:blocker).permit(:category, :blocker_description, :image1, :image2, image3, :resolved, :urgent)
  end
end
