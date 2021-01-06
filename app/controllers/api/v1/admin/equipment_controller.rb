class Api::V1::Admin::EquipmentController < ApplicationController
  protect_from_forgery with: :null_session

  def index
    render json: Equipment.all.pluck(:id, :name)
  end
end
