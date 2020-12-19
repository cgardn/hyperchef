module Api
  module V1
    class AdminController < ApplicationController
      include TokenAuthenticatable

      def index
        render json: Recipe.all
      end

      def edit_recipe
      end

      def new_recipe
      end
    end
  end
end
