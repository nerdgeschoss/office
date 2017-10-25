class KioskController < ApplicationController
  def show
    @products = Product.available_in_kiosk
  end
end
