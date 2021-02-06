module Api
  module V1
    class AuthsController < ApplicationController
      include TokenAuthenticatable

      protect_from_forgery with: :null_session
      skip_before_action :authenticate_user, only: [:create, :create_admin, :check_admin]
      before_action :authenticate_admin, only: [:check_admin]

      def create_admin
        token_command = AuthenticateUserCommand.call(*params.slice(:user, :password).values)
        if token_command.success? and token_command.is_admin? == true;
          render json: {token: token_command.result}
        else
          render json: {error: token_command.errors}, status: :unauthorized
        end
      end

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

      def check_admin
        render json: {}
      end

    end
  end
end
