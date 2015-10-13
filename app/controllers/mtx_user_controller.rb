class MtxUserController < ApplicationController
  layout "admin"
  helper_method :sort_column, :sort_direction
  include MtxUserHelper

  def show_list
    @users = MtxUser.order(sort_column + " " + sort_direction).page(params[:page]).per(2)
    # @orders = MtxOrder.joins(:mtx_user).select('`mtx_orders`.*, `mtx_user`.username as username').order(sort_column + " " + sort_direction).page(params[:page]).per(3)
    # @orders_scope = MtxOrder.ordered_by_username.page(params[:page]).per(2)
    authorize! :show_list, @user
  end

  def show
    @user = MtxUser.find(params[:id])
  end

  # Phu tran
  # Begin
  def new
    @user = MtxUser.new
  end

  def create
    # Create the user from params
    @user = MtxUser.new(user_params)
    if @user.save
      # Deliver the signup email
      UserNotifier.send_signup_email(@user).deliver
      log_in(@user)
      redirect_to root_url
    else
      render 'new'
    end
  end

  def sign_in
  end

  def process_login
    if params[:username].blank? || params[:password].blank?
      flash.now[:danger] = 'Please enter username/password'
      render 'sign_in'
    else
      user = MtxUser.find_by(username: params[:username], password: params[:password])
      if user
        log_in(user)
        redirect_to root_url
      else
        flash.now[:danger] = 'Invalid username/password combination'
        render 'sign_in'
      end
    end


  end

  def destroy
    log_out
    redirect_to root_url
  end

  private

  def user_params
    params.require(:mtx_user).permit(:fullname, :username, :email, :password, :password_confirmation)
  end
  # End

end
