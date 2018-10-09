class PagesController < ApplicationController

  before_action :find_subject
  before_action :confirm_logged_in

  layout 'admin'

  def index
    @pages = @subject.pages.sorted
  end

  def show
    @page = Page.find(params[:id])
  end

  def new
    @page = Page.new(:subject_id => @subject.id)
    @page_count = Page.count + 1
    @subjects = Subject.sorted
  end

  def create
    @page = Page.new(page_params)
    #page_params is a local private metod for whitelisting and require params.
    if @page.save
      flash[:notice] = "Page created successfully."
      redirect_to(pages_path(:subject_id => @subject.id))
    else
      @page_count = Page.count + 1
      @subjects = Subject.sorted
      render('new')
    end
  end

  def edit
    @page = Page.find(params[:id])
    @page_count = Page.count
    @subjects = Subject.sorted
  end

  def update
    @page = Page.find(params[:id])
    #page_params is a local private metod for whitelisting and require params.
    if @page.update_attributes(page_params)
      # if page is updated redirect to show action.
      flash[:notice] = "Page updated successfully."
      redirect_to(page_path(@page, :subject_id => @subject.id))
    else
      # if save fails render template for edit.
      @page_count = Page.count
      @subjects = Subject.sorted
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
    redirect_to(pages_path(:subject_id => @subject.id))
  end

  private
  # Whitelisting params to be mass assigned to an object. Also setting required to param :page
  def page_params
    params.required(:page).permit(:name, :position, :visible, :subject_id, :permalink)
  end

  def find_subject
    @subject = Subject.find(params[:subject_id])
  end
end
