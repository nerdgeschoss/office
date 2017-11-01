class KiosksController < ApplicationController
  def show
    authorize :kiosk
    @users = User.visible_in_kiosk.alphabetical
    @products = Product.available_in_kiosk.alphabetical
  end

  def create
    authorize :kiosk
    product = Product.find params[:button]
    user = User.find params[:user_id]
    user.team.open_invoice.lines.create! product: product, user: user
    redirect_to kiosk_path, notice: t(".purchased", product: product.name)
  end
end
