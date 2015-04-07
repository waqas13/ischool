class EmployeesController < ApplicationController
	def index
		@employees = Employee.all
	end

	def new
		@employee = Employee.new
	end

	def create
		emp = Employee.new(create_params)
		emp.loan = 0
		emp.status = 'active'
		if emp.save
			redirect_to employees_path, :notice => 'Employee Added Successfully'
		end
	end

	def edit
		@employee = Employee.find(params[:id])
	end

	def loan
		@employee = Employee.find(params[:id])
	end

	def update
		emp = Employee.find(params[:id])
	    if emp.update(create_params)
	      redirect_to employees_path, :notice => 'Information Updated successfully!'
	    else
	      redirect_to :back, :alert => 'Could not update information!'
	    end
	end

	def destroy
	    emp = Employee.find(params[:id])
	    emp.destroy
	    redirect_to employees_path, :notice => 'Item Deleted!'
	end

	private
		def create_params
			params.require(:employee).permit(:name, :contact, :address_home, :salary_type, :salary, :iqama, :expire_iqama, :loan, :status)
		end
end
