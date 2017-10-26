class KiosksController < ApplicationController
  def show
    @users = User.all
    @products = Product.available_in_kiosk
  end

  def create
    product = Product.find params[:button]
    user = User.find params[:user_id]
    user.team.open_invoice.lines.create! product: product, user: user
    redirect_to kiosk_path
  end
end
