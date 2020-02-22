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
      redirect_to equipment_index_path
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

    if @equipment.save
      redirect_to equipment_index_path
    else
      render :edit
    end
  end

  def destroy
    @equipment = Equipment.find(params[:id])
    @equipment.delete
    redirect_to equipment_index_path
  end

  private
  
    def equipment_params
      params.require(:equipment).permit(:name)
    end
end
