class EmployeesController < ApplicationController
	def index
		@employees = Employee.where('status !=? ', 'active')
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

	private
		def create_params
			params.require(:employee).permit(:name, :contact, :address_home, :salary_type, :salary, :iqama, :expire_iqama, :loan, :status)
		end
end
