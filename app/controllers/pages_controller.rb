require Rails.root.to_s + "/rubal_core/lib/rubal_core.rb"

class PagesController < ApplicationController
  before_filter :only => ['new', 'create'] do

    @selected_page_type_id = nil

    page_type = nil
    unless params[:page_type].nil?
      pt = PageType.find_by_name(params[:page_type])
      unless pt.nil?
        @selected_page_type_id = pt.id
        page_type =  params[:page_type].to_sym
      end
    end


    @available_substs = RubalCore::PluginManager.instance.get_available_substitutions_descriptions(page_type)
  end

  before_filter :only => ['edit', 'update'] do
    @page = Page.find(params[:id])
    @selected_page_type_id = @page.type_id
    @available_substs = RubalCore::PluginManager.instance.get_available_substitutions_descriptions(@selected_page_type_id)
  end

  # GET /pages
  # GET /pages.json
  def index
    @pages = Page.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @pages }
    end
  end

  # GET /pages/1
  # GET /pages/1.json
  def show
    unless params[:url].nil?
      @page = Page.where(:url => params[:url]).first
    else
      @page = Page.find params[:id]
    end

    append_view_path(Rails.root.to_s)
    render @page.erb_path, :layout  => (@page.layout.nil?) ? false : ('../' + @page.layout.erb_path)
    return

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @page }
    end
  end

  # GET /pages/new
  # GET /pages/new.json
  def new
    @page = Page.new
    @page.type_id= @selected_page_type_id unless @selected_page_type_id.nil?
    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @page }
    end
  end

  # GET /pages/1/edit
  def edit
    #moved to before_filter
    #@page = Page.find(params[:id])
  end

  # POST /pages
  # POST /pages.json
  def create
    @page = Page.new(params[:page])

    respond_to do |format|
      if @page.save
        format.html { redirect_to @page, notice: 'Page was successfully created.' }
        format.json { render json: @page, status: :created, location: @page }
      else
        format.html { render action: "new" }
        format.json { render json: @page.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /pages/1
  # PUT /pages/1.json
  def update
    #moved to before_filter
    #@page = Page.find(params[:id])

    pti = RubalCore::PluginManager.instance.get_page_type_hash PageType.find(@page.type_id).name
    puts "____" + pti.to_s
    unless pti.nil?
      if pti.include? :after_save_block
        pti[:after_save_block].call(params, @page)
      end
    end

    respond_to do |format|
      if @page.update_attributes(params[:page])
        format.html { redirect_to @page, notice: 'Page was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @page.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /pages/1
  # DELETE /pages/1.json
  def destroy
    @page = Page.find(params[:id])
    @page.destroy

    respond_to do |format|
      format.html { redirect_to pages_url }
      format.json { head :no_content }
    end
  end
end
