class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  include CanCan::ControllerAdditions
  protect_from_forgery with: :exception
  before_filter :set_locale

  rescue_from CanCan::AccessDenied do |exception|
    redirect_to permission_message_url
  end
  def sort_column
    # MtxOrder.column_names.include?(params[:sort]) ? params[:sort] : "id"
    # MtxOrder.joins(:mtx_user).select('`mtx_orders`.*, `mtx_user`.username as username').column_names.include?(params[:sort]) ? params[:sort] : "id"
    params[:sort] != nil ? params[:sort] : "id"
  end

  def sort_direction
    %w[asc desc].include?(params[:direction]) ? params[:direction] : "asc"
  end

  private
  def set_locale
    I18n.locale = params[:locale] || I18n.default_locale
    Rails.application.routes.default_url_options[:locale]= I18n.locale
  end

end
