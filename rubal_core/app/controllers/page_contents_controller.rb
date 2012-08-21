class PageContentsController < ApplicationController
  # GET /page_contents
  # GET /page_contents.json
  def index
    @page_contents = PageContent.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @page_contents }
    end
  end

  # GET /page_contents/1
  # GET /page_contents/1.json
  def show
    @page_content = PageContent.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @page_content }
    end
  end

  # GET /page_contents/new
  # GET /page_contents/new.json
  def new
    @page_content = PageContent.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @page_content }
    end
  end

  # GET /page_contents/1/edit
  def edit
    @page_content = PageContent.find(params[:id])
  end

  # POST /page_contents
  # POST /page_contents.json
  def create
    @page_content = PageContent.new(params[:page_content])

    respond_to do |format|
      if @page_content.save
        format.html { redirect_to @page_content, notice: 'Page content was successfully created.' }
        format.json { render json: @page_content, status: :created, location: @page_content }
      else
        format.html { render action: "new" }
        format.json { render json: @page_content.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /page_contents/1
  # PUT /page_contents/1.json
  def update
    @page_content = PageContent.find(params[:id])

    respond_to do |format|
      if @page_content.update_attributes(params[:page_content])
        format.html { redirect_to @page_content, notice: 'Page content was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @page_content.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /page_contents/1
  # DELETE /page_contents/1.json
  def destroy
    @page_content = PageContent.find(params[:id])
    @page_content.destroy

    respond_to do |format|
      format.html { redirect_to page_contents_url }
      format.json { head :no_content }
    end
  end
end
