class SectionsController < ApplicationController
  def index
    @sections = Section.sorted
  end

  def show
    @section = Section.find(params[:id])
  end

  def new
    @section = Section.new
  end

  def create
    @section = Section.new(section_params)
    if @section.save
      flash[:notice] = flash[:notice] = "Section created successfully."
      redirect_to(sections_path)
    else
      render('new')
    end
  end

  def edit
    @section = Section.find(params[:id])
  end

  def update
    @section = Section.find(params[:id])
    if @section.update_attributes(section_params)
      flash[:notice] = flash[:notice] = "Section updated successfully."
      redirect_to(section_path(@section))
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
    flash[:notice] = flash[:notice] = "Section deleted successfully."
    redirect_to(sections_path)
  end

  private
  # Whitelisting params to be mass assigned to an object. Also setting required to param subject
  def section_params
    params.required(:section).permit(:name, :position, :visible, :page_id, :content, :content_type)
  end
end
