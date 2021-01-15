module Api
  module V1
    class AuthsController < ApplicationController
      include TokenAuthenticatable

      protect_from_forgery with: :null_session
      skip_before_action :authenticate_user, only: [:create]

      def create
        token_command = AuthenticateUserCommand.call(*params.slice(:user, :password).values)

        if token_command.success?
          render json: {token: token_command.result}
        else
          render json: {error: token_command.errors}, status: :unauthorized
        end
      end

      def check
        render json: {}
      end

    end
  end
end