require Rails.root.to_s + '/rubal_core/lib/rubal_core/page_processor'
class ThepagesController < ApplicationController
  # GET /thepages
  # GET /thepages.json
  def initialize
    @count_lines = 50
  end

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
  def update_edit_field
    @thepage = Thepage.find(params[:id])
    @vhtml_file_content = File.open(@thepage.vhtml_path, 'r'){|file| file.read}
  end
  def vhtml_edit
    update_edit_field
    save_vhtml


    #session[:return_to] ||= request.referer
    #redirect_to session[:return_to]

    #p 'iiiiiiiii'
    #p params[:id]
    #@thepage = Thepage.find(params[:id])
    ##@count_lines = 0
    #@vhtml_file_content = File.open(@thepage.vhtml_path, 'r'){|file| file.read}
    ##file = File.open(@thepage.vhtml_path, 'r')
    ##content = ''
    ##@vhtml_file_content = file.each{|line|
    ##  content += line
    ##  #@count_lines += 1
    ##}
    ##@vhtml_file_content = content
    #p @vhtml_file_content
    #p 'sssssssss'
    #save = params[:save]
    #p save


    #@vhtml_file_content = @thepage.vhtml_path
  end
  def save_vhtml
    @new_vhtml_file_content = params[:message]
    unless @new_vhtml_file_content.nil?
      File.open(@thepage.vhtml_path, 'w'){|file|
        file.write @new_vhtml_file_content
      }
    end
    #updated_file_content = params[:message]
    #file = File.open(@thepage.vhtml_path, 'r+')
    #file.each{|line|
    #  line = updated_file_content
    #}
    #p '--------------------------------'
    #p updated_file_content
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
