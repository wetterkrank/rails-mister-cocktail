class DosesController < ApplicationController

  def index
  end

  def new
    # raise
    @cocktail = Cocktail.find(params[:cocktail_id])
    @dose = Dose.new()
    @dose.cocktail = @cocktail
  end

  def create
    @dose = Dose.new(dose_params)
    if (@dose.save)
      redirect_to @dose.cocktail, notice: "Success"
    else
      render :new
    end
  end

  private

  def dose_params
    params.require(:dose).permit(:description, :cocktail_id, :ingredient_id)
  end
end
