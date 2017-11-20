class PresenceTimesController < ApplicationController
  def index
    @user = authorize(User.friendly.find(params[:user_id]), :show_presence?)
    @presence_month = DateTime.current + params[:month].to_i.months
    @presence_times = @user.presence_times.in_month(@presence_month)
    response.headers["Content-Disposition"] = "attachment; filename=\"#{@presence_month.year}-#{Date::MONTHNAMES[@presence_month.month]}-#{@user.name}.csv\""
    respond_to :csv
  end
end
