class BlockersController < ApplicationController
  def index
    blockers = Blocker.all
    render json: blockers
  end

  def create
    blocker = Blocker.create(blocker_params)
    if blocker.valid?
      render json: blocker
    else
      render json: blocker.errors
    end
  end

  def update
    blocker = Blocker.find(params[:id])
    blocker.update(blocker_params)
    if blocker.valid?
      render json: blocker
    else
      render json: blocker.errors
    end
  end

  def destroy
    blocker = Blocker.find(params[:id])
    blockers = Blocker.all
    blocker.update(blocker_params)
    if blocker.destroy
      render json: blockers
    else
      render json: blocker.errors
    end
  end

  private
  def blocker_params
    params.require(:blocker).permit(:category, :blocker_description, :image1, :image2, image3, :resolved, :urgent)
  end
end
