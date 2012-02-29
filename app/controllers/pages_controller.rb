#encoding: utf-8
class PagesController < ApplicationController
  # GET /pages
  # GET /pages.json
  before_filter :authenticate_user!, :except => 'show'
  
  include PagesRoles
  include PagesHelper
  
  #оставляем шаблон для действий админки, для show убираем
  layout  false, :except => [:index, :edit, :update, :new, :create]
  
  def self.visible_fields_hash role = nil
    patt = {:name => true, :role => true, :title => true, :page_content => true, :url => true, :subst_name => true, :template => true}
    unless role.nil?
      case role
        #:page => {"id" => 1, "name" => "Страница"},
        #:template => {"id" => 2, "name" => "Шаблон"},
        #:news_short => {"id" => 3, "name" => "Новость в списке"},
        #:news_full => {"id" => 4, "name" => "Полная новость"},
        #:chunk => {"id" => 5, "name" => "Чанк"}
        when :page then 
          patt[:subst_name] = false
          patt[:role] = false
        when :template then 
          patt[:subst_name] = false
          patt[:title] = false
          patt[:url] = false
          patt[:role] = false
        when :news_short, :news_full then 
          patt[:subst_name] = false
          patt[:title] = false
          patt[:url] = false
          patt[:role] = false
          patt[:template] = false
        when :chunk then
          patt[:template] = false
          patt[:title] = false
          patt[:url] = false
          patt[:role] = false
      end
    end
    return patt
  end
  
  def index
    @admin_action_name = "Управление страницами"
    @templates = Page.where(:role => 2)
    @news_templates = Page.where(:role => [3, 4]).order("updated_at desc")
    @pages = Page.where(:role => 1)
    @chunks = Page.where(:role => 5)

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @pages }
    end
  end

  # GET /pages/1
  # GET /pages/1.json
  def show
    if !(params[:url].nil?)
      @page = Page.where(:url => params[:url], :role => 1).first
      @page.additional_params= {"newsid" => params[:newsid]}
    elsif
      @page = Page.find(params[:id])
    end

    if params[:format] == 'json'
      render (render_page_to_json_hash @page)
      return
    end

    respond_to do |format|
      format.html # show.html.erb
      format.json {render (render_page_to_json_hash @page) }
    end
  end

  # GET /pages/new
  # GET /pages/new.json
  def new
    @admin_action_name = "Создание элемента"
    @page = Page.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @page }
    end
  end
  
  # GET /pages/1/edit
  def edit
    @admin_action_name = "Редактирование элемента"
    @page = Page.find(params[:id])
    @page.page_content= read_file @page.path
  end

  # POST /pages
  # POST /pages.json
  def create
    @admin_action_name = "Создание элемента"
    #долго формируем имя нового файлика, хотелось бы сделать его понятным и уникальным
    require 'digest/md5'
    require 'russian'
    r = Random.new
    add_num = r.rand(1...10000000).to_s
    new_name = Russian.translit(params[:page][:name]).downcase.gsub(/\W/, "_") + "__" + Digest::MD5.hexdigest(add_num)[0..6] + ".html"
    params[:page][:path] = "/htmls/" + new_name
    @page = Page.new(params[:page])
    if(roles_hash.has_key? params[:role].to_sym)
      @page.role= roles_hash[params[:role].to_sym]["id"]
    else
      @page.role= roles_hash[params[:page][:role].to_sym]["id"]
    end
    #File.open(Rails.root.to_s + params[:page][:path], 'w+') {|f| f.write(params[:page][:page_content]) }
    rg = Regexp.new('\r\n')
    params[:page][:page_content].gsub!(rg, "\n")
    my_file = File.new(Rails.root.to_s + params[:page][:path], "w+")
    my_file.puts params[:page][:page_content]
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
    @admin_action_name = "Редактирование элемента"
    @page = Page.find(params[:id])

    respond_to do |format|
      if @page.update_attributes(params[:page])
        rg = Regexp.new('\r\n')
        params[:page][:page_content].gsub!(rg, "\n")
        File.open(Rails.root.to_s + @page.path, 'w+') {|f| f.write(params[:page][:page_content]) }
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
    @admin_action_name = "Удаление элемента"
    @page = Page.find(params[:id])
    @page.destroy

    respond_to do |format|
      format.html { redirect_to pages_url }
      format.json { head :no_content }
    end
  end
end