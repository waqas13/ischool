class StudentsController < ApplicationController
	before_action :authenticate_user!

  ####### System admin is 0
  ####### School admin is 1
  ####### School account is 2
  ####### Bank is 3
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
    if current_user && current_user.user_type == 2 || current_user.user_type == 0
  	  result = Student.import(params[:file])
      if result=="notok"
        redirect_to students_upload_path, :alert => "Error in file."
      else
  	    redirect_to students_upload_path, :notice => "Students imported."
      end
    else
      redirect_to authenticated_root_path, :alert => 'Access Denied!'
    end
  end

  def payment
  	if current_user && current_user.user_type == 3
      @students = Student.all
      @std = Student.new
  	else
  		redirect_to authenticated_root_path, :alert => 'Access Denied!'
  	end
  end

  def pay
    if current_user && current_user.user_type == 3
      @std = Student.find(params[:student][:id])
      # return render json: @std
      @std.paid = @std.paid.to_i + params[:student][:paid].to_i
      @std.date = params[:student][:date]
      @std.save!
      redirect_to students_payment_path, :success => 'Payment Updated!'
    else
      redirect_to authenticated_root_path, :alert => 'Access Denied!'
    end
  end
end
