class StudentsController < ApplicationController
	before_action :authenticate_user!
  def index
  	if current_user && current_user.user_type == 1 || current_user.user_type == 0
  		@students = Student.all
  	else
  		redirect_to authenticated_root_path, :alert => 'Access Denied!'
  	end
  end

  def show
  	if current_user && current_user.user_type == 1 || current_user.user_type == 0

  	else
  		redirect_to authenticated_root_path, :alert => 'Access Denied!'
  	end
  end

  def upload
  	if current_user && current_user.user_type == 2 || current_user.user_type == 0

  	else
  		redirect_to authenticated_root_path, :alert => 'Access Denied!'
  	end
  end

  def import
  	Student.import(params[:file])
  	redirect_to students_upload_path, :notice => "Students imported."
  end

  def payment
  	if current_user && current_user.user_type == 3 || current_user.user_type == 0
      @students = Student.all
      @std = Student.new
  	else
  		redirect_to authenticated_root_path, :alert => 'Access Denied!'
  	end
  end

  def pay
    @std = Student.find(params[:student][:id])
    # return render json: @std
    @std.paid = params[:student][:paid]
    @std.date = params[:student][:date]
    @std.save!
    redirect_to students_payment_path, :success => 'Payment Updated!'
  end
end
