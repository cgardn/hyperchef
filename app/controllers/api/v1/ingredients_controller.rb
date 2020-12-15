module Api
  module V1
    class IngredientsController < ApplicationController
      def index
        render json: Ingredients.all()
      end

      def create
      end

      def show
      end

      def update
      end
      
      def destroy
      end
    end
  end
end
