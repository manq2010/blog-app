class UsersController < ApplicationController
  def index
    @users = User.all
  end

  def show
    @user = User.find_by(id: params[:id])
    # if @user.nil?
    #   @users = User.all
    #   flash.now[:alert] = 'User was not found'
    #   render 'index'
    # end
  end
end
