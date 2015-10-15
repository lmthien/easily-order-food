module MtxUserHelper
  # Logs in the given user.
  def log_in(user)
    session[:user_id] = user.id
  end

  # Returns the current logged-in user (if any).
  def current_user
    @current_user ||= MtxUser.find_by(id: session[:user_id])
  end

  # Returns true if the user is logged in, false otherwise.
  def logged_in?
    !current_user.nil?
  end

  # Logs out the current user.
  def log_out
    session.delete(:user_id)
    session.delete(:order_items)
    @current_user = nil

  end

  def user_role
    current_user.user_type == 1 ? "- Admin" : "- Customer"
  end
end
