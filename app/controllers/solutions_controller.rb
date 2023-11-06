class SolutionsController < ApplicationController
  def index
    solutions = Solution.all
    render json: solutions
  end

  def create
    solution = Solution.create(solution_params)
    if solution.valid?
      render json: solution
    else
      render json: solution.errors
    end
  end

  def update
    solution = Solution.find(params[:id])
    solution.update(solution_params)
    if solution.valid?
      render json: solution
    else
      render json: solution.errors
    end
  end

  def destroy
    solution = Solution.find(params[:id])
    solutions = Solution.all
    if solution.destroy
      render json: solutions, status: 204
    else
      render json: solution.errors
    end
  end
  
  private
  def solution_params
    params.require(:solution).permit(:description, :image1, :image2, :image3, :require_followup, :attempted, :acceptable, :user_id, :blocker_id)
  end
end
