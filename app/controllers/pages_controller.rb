class PagesController < ApplicationController
  layout 'admin'

  def index
    @pages = Page.sorted
  end

  def show
    @page = Page.find(params[:id])
  end

  def new
    @page = Page.new
  end

  def create
    @page = Page.new(page_params)
    #page_params is a local private metod for whitelisting and require params.
    if @page.save
      flash[:notice] = "Page created successfully."
      redirect_to(pages_path)
    else
      render('new')
    end
  end

  def edit
    @page = Page.find(params[:id])
  end

  def update
    @page = Page.find(params[:id])
    #page_params is a local private metod for whitelisting and require params.
    if @page.update_attributes(page_params)
      # if page is updated redirect to show action.
      flash[:notice] = "Page updated successfully."
      redirect_to(page_path(@page))
    else
      # if save fails render template for edit.
      render('edit')
    end
  end

  def delete
    @page = Page.find(params[:id])
  end

  def destroy
    @page = Page.find(params[:id])
    @page.destroy
    flash[:notice] = "Page deleted successfully."
    redirect_to(pages_path)
  end

  private
  # Whitelisting params to be mass assigned to an object. Also setting required to param :page
  def page_params
    params.required(:page).permit(:name, :position, :visible, :subject_id, :permalink)
  end
end
