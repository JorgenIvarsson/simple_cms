class SubjectsController < ApplicationController

  before_action :confirm_logged_in
  before_action :set_section_count, :only => [:new, :create, :edit, :update]

  layout 'admin'

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
      flash[:notice] = "Subject created successfully."
      redirect_to(subjects_path)
    else
      # If save fails, just render the New template with the same @subject
      render('new')
    end
  end

  def edit
    @subject = Subject.find(params[:id])
  end

  def update
    #subject_params is a local private metod for whitelisting and require params.
    @subject = Subject.find(params[:id])

    if @subject.update_attributes(subject_params)
        # if subject saved redirect to show action.
      flash[:notice] = "Subject updated successfully."
      redirect_to(subject_path(@subject))
    else
      # If save fails, just render the Edit template with the same @subject
      render('edit')
    end
  end

  def delete
    @subject = Subject.find(params[:id])
  end

  def destroy
    @subject = Subject.find(params[:id])
    @subject.destroy
    flash[:notice] = "Subject '#{@subject.name}' destroyed successfully."
    redirect_to(subjects_path)
  end

  private
  # Whitelisting params to be mass assigned to an object. Also setting required to param subject
  def subject_params
    params.required(:subject).permit(:name, :position, :visible, :created_at)
  end

  def set_section_count
    @subject_count = Subject.count
    if params[:action] == 'new' || params[:action] == 'create'
      @subject_count += 1
    end
  end

end
