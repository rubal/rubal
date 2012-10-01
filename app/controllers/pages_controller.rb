#encoding: utf-8

require Rails.root.to_s + "/rubal_core/lib/rubal_core"
require_relative "../../rubal_core/lib/rubal_core/rubal_controller"
include RubalCore::RubalLogger

class PagesController < ApplicationController
  skip_filter :rubal_authenticate, :only => [:permission_denied]

  before_filter :only => ['new', 'create', 'edit', 'update'] do
    # TODO сделать нормально

    plugin_manager = RubalCore::PluginManager.instance

    @page_type = nil

    begin
      if ['new', 'create'].include? action_name.to_s
        @page = Page.new


        unless params[:page_type].nil?
          @page_type = PageType.find_by_name(params[:page_type])
          @page.type_id= @page_type.id
        end

        unless params[:page].blank?
          @page_type = PageType.find(params[:page][:type_id]) unless params[:page][:type_id].blank?
        end

      elsif ['edit', 'update'].include? action_name.to_s
        @page = Page.find(params[:id])
        @page_type = PageType.find(@page.type_id)
      end

      if ['create', 'update'].include? action_name.to_s
        @page.params_for_type_before_save= params unless @page_type.before_save.nil?
      end
    rescue
      puts "FAIL "*100
      @page_type = nil
    end

    if @page_type.nil? || @page.nil?
      flash[:notice] = "Неизвестный тип страницы"
      redirect_to :pages
    end

    @available_substs = plugin_manager.get_available_substitutions_descriptions(@page_type.id)

    @allowed_form_fields = [:url, :title, :layout]

    unless @page_type.form_fields.nil?
      @allowed_form_fields = @allowed_form_fields & @page_type.form_fields
    end

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

    rubal_render @page
    #             .erb_path, :layout  => (@page.layout.nil?) ? false : ('../' + @page.layout.erb_path)
    #return
    #
    #respond_to do |format|
    #  format.html # show.html.erb
    #  format.json { render json: @page }
    #end
  end

  # GET /pages/new
  # GET /pages/new.json
  def new
    # creating page moved to before_filter

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @page }
    end
  end

  # GET /pages/1/edit
  def edit
    # finding page moved to before_filter
    # @page = Page.find(params[:id])
  end

  # POST /pages
  # POST /pages.json
  def create
    # creating page moved to before_filter



    respond_to do |format|
      if @page.update_attributes(params[:page])
        format.html { redirect_to @page, notice: 'Страница создана.' }
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
    # finding page moved to before_filter
    #@page = Page.find(params[:id])

    respond_to do |format|
      if @page.update_attributes(params[:page])
        format.html { redirect_to @page, notice: 'Страница изменена.' }
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

  def perf_test_create
    render :inline => 'lol'
    return

    require "time"
    t1 = Time.now

    Page.all.each{|p| p.destroy}
    num = 0
    a = 10
    num.times do
      a += 3
      Page.create({:name => "fuck you, test #{a}", :type_id => 1})
    end
    arrr = []
    Page.all.each{|p|
      arrr << p.id
    }

    arrr.each{|i|
      pp = Page.find(i)
      puts pp.created_at
    }

    render :inline => (Time.now - t1).to_s
  end

  def permission_denied
    sign_out(current_user)
  end
end
