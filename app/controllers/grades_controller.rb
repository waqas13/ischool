class GradesController < ApplicationController
  def index
  	@grades = Grade.all
  end

  def show
  	# return render json: params.inspect
  	@grade = Grade.find(params[:id])
  	@students = @grade.students.where('staus !=? ', 'delete')
  end

  def edit
  	@grade = Grade.find(params[:id])
  end

  def update
  	# return render json: params.inspect
  	grade = Grade.find(params[:id])
    if grade.update(create_params)
      redirect_to grade_path(grade.id), :notice => 'Information Updated successfully!'
    else
      redirect_to grade_path(grade.id), :alert => 'Could not update information!'
    end
  end

  def new
  	@grade = Grade.new
  end

  def create
  	# return render json: params.inspect
  	grade = Grade.create(create_params)
    if grade.save!
      redirect_to grades_path, :notice => 'Class added successfully!'
    else
      redirect_to :back, :alert => "Fill the form again!"
    end
  end

  def validateClassTitle
  	user = Grade.find_by_title(params[:title])
    value = user.present?
    respond_to do |format|
      format.json {render json: value}
    end
  end

  def addFeeToClass
  	# return render json: params.inspect
  	grade = Grade.find(params[:id])
  	grade.students.try(:each) do |std|
  		std.amount = std.amount+grade.fee 
  		std.save!
  	end
  	redirect_to grade_path(grade.id), :notice => 'Successfully notified and fee updated!'
  end

  private
    def create_params
      params.require(:grade).permit(:title, :fee)      
    end
end
