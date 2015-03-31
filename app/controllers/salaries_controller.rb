class SalariesController < ApplicationController
  def index
  	@salaries = Salary.all
  end

  def create
  	
  end
end
