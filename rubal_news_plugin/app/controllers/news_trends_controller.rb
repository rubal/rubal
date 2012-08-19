class NewsTrendsController < ApplicationController
  # GET /news_trends
  # GET /news_trends.json
  def index
    @news_trends = NewsTrend.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @news_trends }
    end
  end

  # GET /news_trends/1
  # GET /news_trends/1.json
  def show
    @news_trend = NewsTrend.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @news_trend }
    end
  end

  # GET /news_trends/new
  # GET /news_trends/new.json
  def new
    @news_trend = NewsTrend.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @news_trend }
    end
  end

  # GET /news_trends/1/edit
  def edit
    @news_trend = NewsTrend.find(params[:id])
  end

  # POST /news_trends
  # POST /news_trends.json
  def create
    @news_trend = NewsTrend.new(params[:news_trend])

    respond_to do |format|
      if @news_trend.save
        format.html { redirect_to @news_trend, notice: 'News trend was successfully created.' }
        format.json { render json: @news_trend, status: :created, location: @news_trend }
      else
        format.html { render action: "new" }
        format.json { render json: @news_trend.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /news_trends/1
  # PUT /news_trends/1.json
  def update
    @news_trend = NewsTrend.find(params[:id])

    respond_to do |format|
      if @news_trend.update_attributes(params[:news_trend])
        format.html { redirect_to @news_trend, notice: 'News trend was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @news_trend.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /news_trends/1
  # DELETE /news_trends/1.json
  def destroy
    @news_trend = NewsTrend.find(params[:id])
    @news_trend.destroy

    respond_to do |format|
      format.html { redirect_to news_trends_url }
      format.json { head :no_content }
    end
  end
end
