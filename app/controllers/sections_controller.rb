class SectionsController < ApplicationController

  before_action :find_page
  before_action :confirm_logged_in
  before_action :set_section_count, :only => [:new, :create, :edit, :update]

  layout 'admin'

  def index
    @sections = @page.sections.sorted
  end

  def show
    @section = Section.find(params[:id])
  end

  def new
    @section = Section.new(:page_id => @page.id)
  end

  def create
    @section = Section.new(section_params)
    @section.page = @page
    if @section.save
      flash[:notice] = flash[:notice] = "Section created successfully."
      redirect_to(sections_path(:page_id => @page.id))
    else
      render('new')
    end
  end

  def edit
    @section = Section.find(params[:id])
    @pages = Page.sorted
  end

  def update
    @section = Section.find(params[:id])
    if @section.update_attributes(section_params)
      flash[:notice] = flash[:notice] = "Section updated successfully."
      redirect_to(section_path(@section, :page_id => @page.id))
    else
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
    redirect_to(sections_path(:page_id => @page.id))
  end

  private
  # Whitelisting params to be mass assigned to an object. Also setting required to param subject
  def section_params
    params.required(:section).permit(:name, :position, :visible, :content, :content_type)
  end

  def find_page
    @page = Page.find(params[:page_id])
  end

  def set_section_count
    @section_count = @page.sections.count
    if params[:action] == 'new' || params[:action] == 'create'
      @section_count += 1
    end
  end
end
