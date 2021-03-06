class PagesController < ApplicationController

  before_filter :authenticate, :except => [:index]
  before_filter :find_page

  def create
    @page = Page.new(params[:page])
    respond_to do |format|
      if @page.save
        flash[:notice] = 'Page was successfully created.'
        format.html { redirect_to pages_path }
        format.xml  { render :xml => @page, :status => :created, :location => @page }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @page.errors, :status => :unprocessable_entity }
      end
    end
  end

  def destroy
    respond_to do |format|
      if @page.destroy
        flash[:notice] = 'Page was successfully destroyed.'        
        format.html { redirect_to pages_path }
        format.xml  { head :ok }
      else
        flash[:error] = 'Page could not be destroyed.'
        format.html { redirect_to @page }
        format.xml  { head :unprocessable_entity }
      end
    end
  end

  def index
    @pages = Page.all(:order => 'position')
    respond_to do |format|
      format.html
      format.xml  { render :xml => @pages }
      format.json { render :json => @pages.to_json(:methods => :html_body) }
    end
  end

  def edit
  end

  def new
    @page = Page.new
    respond_to do |format|
      format.html
      format.xml  { render :xml => @page }
    end
  end

  def show
    respond_to do |format|
      format.html
      format.xml  { render :xml => @page }
    end
  end

  def update
    respond_to do |format|
      if @page.update_attributes(params[:page])
        flash[:notice] = 'Page was successfully updated.'
        format.html { redirect_to pages_path }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @page.errors, :status => :unprocessable_entity }
      end
    end
  end

  private

  def find_page
    @page = Page.find(params[:id]) if params[:id]
  end

end