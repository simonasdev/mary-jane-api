module APIHelper
  def current_user
    @current_user ||= set_current_user
  end
end