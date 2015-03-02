class StudentsController < ApplicationController
	before_action :authenticate_user!

  ####### System admin is 0
  ####### School admin is 1
  ####### exams is 2
  ####### accounts is 3
  def index
  	if current_user && current_user.user_type == 1 || current_user.user_type == 0
  		@students = Student.where('staus !=?', 'delete')
  	else
  		redirect_to authenticated_root_path, :alert => 'Access Denied!'
  	end
  end

  def new
    @student = Student.new
  end

  def create
    # return render json: params.inspect
    @student = Grade.find(params[:student][:grade_id]).students.create(create_params)
    if @student.save!
      @student.amount = Grade.find(params[:student][:grade_id]).fee
      @student.staus = ''
      @student.save!
      User.create!(email: @student.email, password: "school", user_type: 4, password_confirmation: "school")
      redirect_to students_path, :notice => 'Student added successfully!'
    else
      redirect_to :back, :alert => "Fill the form again!"
    end
  end

  def show
  	if current_user && current_user.user_type == 1 || current_user.user_type == 0
      @student = Student.find(params[:id])

  	else
  		redirect_to authenticated_root_path, :alert => 'Access Denied!'
  	end
  end

  def upload
  	if current_user && current_user.user_type == 1 || current_user.user_type == 0

  	else
  		redirect_to authenticated_root_path, :alert => 'Access Denied!'
  	end
  end

  def edit
    @student = Student.find(params[:id])
  end

  def update
    @student = Student.find(params[:id])
    if @student.update(create_params)
      redirect_to student_path(@student.id), :notice => 'Information Updated successfully!'
    else
      redirect_to student_path(@student.id), :alert => 'Could not update information!'
    end
  end

  def destroy
    student = Student.find(params[:id])
    student.staus = 'delete'
    student.save!
    user = User.find_by_email(student.email)
    user.delete
    redirect_to students_path, :notice => 'Student deleted!'
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
      @students = Student.where('staus !=?', 'delete')
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

  def validate_model
    user = User.find_by_email(params[:email])
    value = user.present?
    respond_to do |format|
      format.json {render json: value}
    end
  end

  def validate_rollnum
    user = Grade.find(params[:grade]).students.find_by_rollnum(params[:roll_Number]);
    value = user.present?
    respond_to do |format|
      format.json {render json: value}
    end
  end

  private
    def create_params
      params.require(:student).permit(:name, :sirname, :contact, :address, :email, :grade_id, :dob, :status, :rollnum ,:gender)      
    end
end
