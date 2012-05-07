class FoobarsController < ApplicationController
  # GET /foobars
  # GET /foobars.json
  def index
    @foobars = Foobar.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @foobars }
    end
  end

  # GET /foobars/1
  # GET /foobars/1.json
  def show
    @foobar = Foobar.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @foobar }
    end
  end

  # GET /foobars/new
  # GET /foobars/new.json
  def new
    @foobar = Foobar.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @foobar }
    end
  end

  # GET /foobars/1/edit
  def edit
    @foobar = Foobar.find(params[:id])
  end

  # POST /foobars
  # POST /foobars.json
  def create
    @foobar = Foobar.new(params[:foobar])

    respond_to do |format|
      if @foobar.save
        format.html { redirect_to @foobar, notice: 'Foobar was successfully created.' }
        format.json { render json: @foobar, status: :created, location: @foobar }
      else
        format.html { render action: "new" }
        format.json { render json: @foobar.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /foobars/1
  # PUT /foobars/1.json
  def update
    @foobar = Foobar.find(params[:id])

    respond_to do |format|
      if @foobar.update_attributes(params[:foobar])
        format.html { redirect_to @foobar, notice: 'Foobar was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @foobar.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /foobars/1
  # DELETE /foobars/1.json
  def destroy
    @foobar = Foobar.find(params[:id])
    @foobar.destroy

    respond_to do |format|
      format.html { redirect_to foobars_url }
      format.json { head :no_content }
    end
  end
end
