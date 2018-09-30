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
    # If save fails, just render the new template with the same @subject
    else
      # render the New template. The New template is expecting @subject and that's what it's getting
      # The form will have all parameters pre populated in the form thanks to the @subject.
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
