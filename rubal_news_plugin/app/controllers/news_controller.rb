#encoding: utf-8

class NewsController < ApplicationController
  # GET /news
  # GET /news.json

  before_filter :only => [:new, :create] do
    @selected_trend = nil
    unless params[:selected_trend_id].blank?
      begin
      @selected_trend = NewsTrend.find(params[:selected_trend_id])
      rescue
        @selected_trend = nil
      end
    end
  end

  def index
    @trends = []
    NewsTrend.all.each do |nt|
      @trends.push({:name => nt.name, :id => nt.id, :news => News.find_all_by_trend_id(nt.id)})
    end

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @news }
    end
  end

  # GET /news/1
  # GET /news/1.json
  def show
    @news = News.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @news }
    end
  end

  # GET /news/new
  # GET /news/new.json
  def new
    @news = News.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @news }
    end
  end

  # GET /news/1/edit
  def edit
    @news = News.find(params[:id])
  end

  # POST /news
  # POST /news.json
  def create
    @news = News.new(params[:news])

    respond_to do |format|
      if @news.save
        format.html { redirect_to @news, notice: 'Новость добавлена.' }
        format.json { render json: @news, status: :created, location: @news }
      else
        format.html { render action: "new" }
        format.json { render json: @news.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /news/1
  # PUT /news/1.json
  def update
    @news = News.find(params[:id])

    respond_to do |format|
      if @news.update_attributes(params[:news])
        format.html { redirect_to @news, notice: 'Новость изменена.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @news.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /news/1
  # DELETE /news/1.json
  def destroy
    @news = News.find(params[:id])
    @news.destroy

    respond_to do |format|
      format.html { redirect_to news_index_url }
      format.json { head :no_content }
    end
  end

  def news_with_trend
    unless params[:url].nil?
      @page = Page.find_by_url(params[:url])
    else
      @page = Page.find params[:id]
    end

    trend = @page.additional_params[:trend_id]

    @news = (trend.nil?) ? News.all : News.where(:trend_id => trend).order(:created_at)

    append_view_path(Rails.root.to_s)
    render @page.erb_path, :layout  => (@page.layout.nil?) ? false : ('../' + @page.layout.erb_path)
    return
  end
end
