class MtxUserController < ApplicationController
  layout "admin"
  helper_method :sort_column, :sort_direction

  def show_list
    @users = MtxUser.order(sort_column + " " + sort_direction).page(params[:page]).per(20)
    # @orders = MtxOrder.joins(:mtx_user).select('`mtx_orders`.*, `mtx_user`.username as username').order(sort_column + " " + sort_direction).page(params[:page]).per(3)
    # @orders_scope = MtxOrder.ordered_by_username.page(params[:page]).per(2)
  end

  def show
    @user = MtxUser.find(params[:id])
  end

  def changeStatus
    @user = MtxUser.find(params[:id])
    @user.active = params[:status]
    @user.save
    render json: @user

    #redirect_to mtx_user_show_list_path, notice: 'User was successfully created.'
  end
end
