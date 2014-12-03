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

  	else
  		redirect_to authenticated_root_path, :alert => 'Access Denied!'
  	end
  end
end
