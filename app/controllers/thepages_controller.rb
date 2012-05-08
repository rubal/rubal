require Rails.root.to_s + '/rubal_core/lib/rubal_core/page_processor'
class ThepagesController < ApplicationController
  # GET /thepages
  # GET /thepages.json
  def index
    @thepages = Thepage.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @thepages }
    end
  end

  # GET /thepages/1
  # GET /thepages/1.json
  def show
    @thepage = Thepage.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @thepage }
    end
  end

  # GET /thepages/new
  # GET /thepages/new.json
  def new
    @thepage = Thepage.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @thepage }
    end
  end

  # GET /thepages/1/edit
  def edit
    @thepage = Thepage.find(params[:id])
  end

  # POST /thepages
  # POST /thepages.json
  def create
    @thepage = Thepage.new(params[:thepage])

    respond_to do |format|
      if @thepage.save
        format.html { redirect_to @thepage, notice: 'Thepage was successfully created.' }
        format.json { render json: @thepage, status: :created, location: @thepage }
      else
        format.html { render action: "new" }
        format.json { render json: @thepage.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /thepages/1
  # PUT /thepages/1.json
  def update
    @thepage = Thepage.find(params[:id])

    respond_to do |format|
      if @thepage.update_attributes(params[:thepage])
        format.html { redirect_to @thepage, notice: 'Thepage was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @thepage.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /thepages/1
  # DELETE /thepages/1.json
  def destroy
    @thepage = Thepage.find(params[:id])
    @thepage.destroy

    respond_to do |format|
      format.html { redirect_to thepages_url }
      format.json { head :no_content }
    end
  end
  def vhtml_edit
    @thepage = Thepage.find(params[:id])
    file = File.open(@thepage.vhtml_path, 'r+')
    @vhtml_file_content = file.inject{|content, line|
      content += line
    }
    p @vhtml_file_content
    #@vhtml_file_content = @thepage.vhtml_path
  end
  def save_vhtml
    updated_file_content = params[:reason]
    file = File.open(@thepage.vhtml_path, 'r+')
    file.each{|line|
      line = updated_file_content
    }
    p '--------------------------------'
    p updated_file_content
    #@thepage = Thepage.find(params[:id])
    #respond_to do |format|
    #  if @thepage.update_attributes(params[:thepage])
    #    format.html { redirect_to @thepage, notice: 'Thepage was successfully updated.' }
    #    format.json { head :no_content }
    #  else
    #    format.html { render action: "edit" }
    #    format.json { render json: @thepage.errors, status: :unprocessable_entity }
    #  end
    #end
  end
end

page = Thepage.new
page.erb_path= Rails.root.to_s + '/pages/erb/supertest.erb'
page.vhtml_path= Rails.root.to_s + '/pages/html/supertest.html'
page.page_url= 'some/relative/page/url'
#page.used_plugins=
page.page_title= 'Title Page'
#page.html_returned_by_plugins=
#page.parent_page= id_parent_page/somepage.id
page.save

PageProcessor.process page.vhtml_path page.erb_path
