class SubjectsController < ApplicationController

  def index
    @subjects = Subject.sorted
  end

  def show
    @subject = Subject.find(params[:id])
  end

  def new
    @subject = Subject.new
  end

  def create
    #subject_params is a local private metod for whitelisting and require params.
    @subject = Subject.new(subject_params)
    # if subject saved redirect to subjects list
    if @subject.save
      redirect_to(subjects_path)
    else
      # If save fails, just render the New template with the same @subject
      render('new')
    end
  end

  def edit
  end

  def update
  end

  def delete
  end

  def destroy
  end

  private
  # Whitelisting params to be mass assigned to an object. Also setting required to param subject
  def subject_params
    params.required(:subject).permit(:name, :position, :visible)
  end

end
