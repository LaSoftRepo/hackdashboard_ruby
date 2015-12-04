class Api::V1::Users::RegistrationsController < Devise::RegistrationsController
  skip_before_action :verify_authenticity_token

  respond_to :html, :json

  def create
    @user = User.find_by!(invite_token: params[:user][:invite_token])
    #return expired unless @user.invite_token_period_valid?(2)
      if @user.update(full_name: params[:user][:full_name], password: params[:user][:password],
          password_confirmation: params[:user][:password_confirmation], invite_token: nil,  invite_token_sent_at: nil )
        render json: { success: true, user: { email: @user.email, role: @user.role, auth_token: AuthenticationService.new(@user).auth_token } }, status: 201
      else
        render json: { success: false, errors: @user.errors.full_messages }, status: 422
      end
  end

  private

  def expired
     render json: {errors: ['Your invite expired.']}, status: 419
  end

end