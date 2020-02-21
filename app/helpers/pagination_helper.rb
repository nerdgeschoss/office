# frozen_string_literal: true

module PaginationHelper
  def paginate(scope, options = {})
    render "components/paginate", scope: scope, options: options
  end

  def first_page?
    params[:page].to_i <= 1
  end
end
