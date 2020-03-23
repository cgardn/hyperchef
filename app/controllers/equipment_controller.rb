class EquipmentController < ApplicationController

  def index
    @equipment = Equipment.all
  end

  def new
    @equipment = Equipment.new
  end

  def create
    @equipment = Equipment.new(equipment_params)
    if @equipment.save
      redirect_to admin_path
    else
      render :new
    end
  end

  def edit
    @equipment = Equipment.find(params[:id])
  end

  def update
    @equipment = Equipment.find(params[:id])
    @equipment.name = equipment_params[:name]
    @equipment.affiliate_link = equipment_params[:affiliate_link]

    if @equipment.save
      redirect_to admin_path
    else
      render :edit
    end
  end

  def destroy
    @equipment = Equipment.find(params[:id])
    @equipment.delete
    redirect_to admin_path
  end

  private
  
    def equipment_params
      params.require(:equipment).permit(:name, :affiliate_link)
    end
end
