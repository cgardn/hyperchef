class Api::V1::Admin::EquipmentController < ApplicationController
  include TokenAuthenticatable
  protect_from_forgery with: :null_session

  def index
    render json: Equipment.all.pluck(:id, :name)
  end

  def create
    if params[:name]
      eq = Equipment.new(name: params[:name])
      out = eq.save
    end
    out ? (render json: eq) : (render json: "")
  end

  def update
    if params[:id]
      equipment = Equipment.find(params[:id])
      equipment.name = params[:name]
      equipment.save
    end
    FilterGraph.rebuild_filters()
    render json: equipment
  end

  def destroy
    if params[:id]
      equipment = Equipment.find(params[:id])
      equipment.destroy
    end
    render json: {}, status: :no_content
    FilterGraph.rebuild_filters()
  end

  private
  def equipment_params
    params.permit(:id, :name)
  end
end
