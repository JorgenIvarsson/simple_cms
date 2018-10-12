class SectionsController < ApplicationController

  before_action :find_page
  before_action :find_subject
  before_action :confirm_logged_in

  layout 'admin'

  def index
    @sections = @page.sections.sorted
  end

  def show
    @section = Section.find(params[:id])
  end

  def new
    @section = Section.new(:page_id => @page.id)
    @section_count = Section.count + 1
    @pages = Page.sorted
  end

  def create
    @section = Section.new(section_params)
    if @section.save
      flash[:notice] = flash[:notice] = "Section created successfully."
      redirect_to(sections_path(:page_id => @page.id, :subject_id => @subject.id))
    else
      @section_count = Section.count + 1
      @pages = Page.sorted
      render('new')
    end
  end

  def edit
    @section = Section.find(params[:id])
    @section_count = Section.count
    @pages = Page.sorted
  end

  def update
    @section = Section.find(params[:id])
    if @section.update_attributes(section_params)
      flash[:notice] = flash[:notice] = "Section updated successfully."
      redirect_to(section_path(@section, :page_id => @page.id,:subject_id => @subject.id))
    else
      @section_count = Section.count
      @pages = Page.sorted
      render('edit')
    end
  end

  def delete
    @section = Section.find(params[:id])
  end

  def destroy
    @section = Section.find(params[:id])
    @section.destroy
    flash[:notice] = "Section deleted successfully."
    redirect_to(sections_path(:page_id => @page.id, :subject_id => @subject.id))
  end

  private
  # Whitelisting params to be mass assigned to an object. Also setting required to param subject
  def section_params
    params.required(:section).permit(:name, :position, :visible, :page_id, :content, :content_type)
  end

  def find_page
    @page = Page.find(params[:page_id])
  end
  def find_subject
    @subject = Subject.find(params[:subject_id])
  end
end
