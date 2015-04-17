module APIHelper
  def declared params
    super(params, include_missing: false)
  end

  def current_user
    @current_user ||= set_current_user
  end
end