class MtxUserController < ApplicationController
  helper_method :sort_column, :sort_direction

  def show_list
    @users = MtxUser.order(sort_column + " " + sort_direction).page(params[:page]).per(2)
    # @orders = MtxOrder.joins(:mtx_user).select('`mtx_orders`.*, `mtx_user`.username as username').order(sort_column + " " + sort_direction).page(params[:page]).per(3)
    # @orders_scope = MtxOrder.ordered_by_username.page(params[:page]).per(2)
  end

  def show
    @user = MtxUser.find(params[:id])
  end

  private

  def sort_column
    # MtxOrder.column_names.include?(params[:sort]) ? params[:sort] : "id"
    # MtxOrder.joins(:mtx_user).select('`mtx_orders`.*, `mtx_user`.username as username').column_names.include?(params[:sort]) ? params[:sort] : "id"
    params[:sort] != nil ? params[:sort] : "id"
  end

  def sort_direction
    %w[asc desc].include?(params[:direction]) ? params[:direction] : "asc"
  end
end
