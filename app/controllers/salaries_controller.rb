class SalariesController < ApplicationController
  def index
  	@salaries = Salary.all
  end

  def new
  	@employee = Employee.find(params[:format]) 
  	@salary = @employee.salaries.new
  end

  def create
  	salary = Salary.new(create_params)
    emp = Employee.find(salary.employee_id)
    emp.loan = emp.loan - salary.loan_amount
    emp.save!
    fund = Fund.first
    fund.amount = fund.amount + salary.loan_amount - emp.salary
    fund.save
  	if salary.save!
      redirect_to salaries_path, :notice => 'Salary Paid successfully!'
    else
      redirect_to :back, :alert => "Sorry! There is an error!"
    end
  end

  def destroy
    sal = Salary.find(params[:id])
    f = Fund.first
    f.amount = f.amount + (sal.employee.salary - sal.loan_amount)
    f.save
    sal.destroy
    redirect_to salaries_path, alert: 'Salary Deleted'
  end

  private
    def create_params
      params.require(:salary).permit(:employee_id, :loan_amount, :status, :created_at)      
    end
end
