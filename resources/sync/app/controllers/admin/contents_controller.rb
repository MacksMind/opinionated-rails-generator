class Admin::ContentsController < ApplicationController
  before_filter :authenticate_user!
  skip_before_filter :verify_authenticity_token, :only => :sort
  load_resource :find_by => :slug
  authorize_resource

  # GET /contents
  # GET /contents.xml
  def index
    @contents = @contents.order(:position)
    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @contents }
    end
  end

  # GET /contents/1
  # GET /contents/1.xml
  def show
    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @content }
    end
  end

  # GET /contents/new
  # GET /contents/new.xml
  def new
    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @content }
    end
  end

  # GET /contents/1/edit
  def edit
  end

  # POST /contents
  # POST /contents.xml
  def create
    respond_to do |format|
      if @content.save
        format.html { redirect_to([:admin,@content], :notice => 'Content was successfully created.') }
        format.xml  { render :xml => @content, :status => :created, :location => @content }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @content.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /contents/1
  # PUT /contents/1.xml
  def update
    respond_to do |format|
      if @content.update_attributes(params[:content])
        format.html { redirect_to([:admin,@content], :notice => 'Content was successfully updated.') }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @content.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /contents/1
  # DELETE /contents/1.xml
  def destroy
    @content.destroy

    respond_to do |format|
      format.html { redirect_to(admin_contents_url) }
      format.xml  { head :ok }
    end
  end

  def sort
    params[:content].each_with_index do |id, index|
      Content.find(id).update_attribute(:position,index+1)
    end

    render :nothing => true
  end
end
