module APIHelper
  def declared_params
    declared params, include_missing: false
  end

  def current_user
    @current_user ||= set_current_user
  end
end