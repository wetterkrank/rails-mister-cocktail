class DosesController < ApplicationController

  def index
  end

  def new
    @cocktail = Cocktail.find(params[:cocktail_id])
    @dose = Dose.new()
    @dose.cocktail = @cocktail
  end

  def create
    @dose = Dose.new(dose_params)
    @cocktail = Cocktail.find(params[:cocktail_id])
    @dose.cocktail = @cocktail
    if (@dose.save)
      redirect_to @dose.cocktail
    else
      # render :new  # this renders the :new view for doses controller
      # render "cocktails/show"  # this renders the cocktails/show view, but the URL isn't nice
      redirect_to @dose.cocktail, notice: "Error while saving the ingredient"
    end
  end

  def destroy
    @dose = Dose.find(params[:id])
    @dose.destroy  # deletes the db record and freezes the instance
    redirect_to @dose.cocktail
  end

  private

  def dose_params
    params.require(:dose).permit(:description, :cocktail_id, :ingredient_id)
  end
end
