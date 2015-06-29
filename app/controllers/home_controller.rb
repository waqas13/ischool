class HomeController < ApplicationController
  def index
  end

  def reports
  	@customers = Customer.all
  	@items = Item.all
  end
end
