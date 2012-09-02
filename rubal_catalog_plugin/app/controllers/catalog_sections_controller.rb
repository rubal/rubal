class CatalogSectionsController < ApplicationController
  # GET /catalog_sections
  # GET /catalog_sections.json
  def index
    @catalog_sections = CatalogSection.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @catalog_sections }
    end
  end

  # GET /catalog_sections/1
  # GET /catalog_sections/1.json
  def show
    @catalog_section = CatalogSection.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @catalog_section }
    end
  end

  # GET /catalog_sections/new
  # GET /catalog_sections/new.json
  def new
    @catalog_section = CatalogSection.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @catalog_section }
    end
  end

  # GET /catalog_sections/1/edit
  def edit
    @catalog_section = CatalogSection.find(params[:id])
  end

  # POST /catalog_sections
  # POST /catalog_sections.json
  def create
    @catalog_section = CatalogSection.new(params[:catalog_section])

    respond_to do |format|
      if @catalog_section.save
        format.html { redirect_to @catalog_section, notice: 'Catalog section was successfully created.' }
        format.json { render json: @catalog_section, status: :created, location: @catalog_section }
      else
        format.html { render action: "new" }
        format.json { render json: @catalog_section.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /catalog_sections/1
  # PUT /catalog_sections/1.json
  def update
    @catalog_section = CatalogSection.find(params[:id])

    respond_to do |format|
      if @catalog_section.update_attributes(params[:catalog_section])
        format.html { redirect_to @catalog_section, notice: 'Catalog section was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @catalog_section.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /catalog_sections/1
  # DELETE /catalog_sections/1.json
  def destroy
    @catalog_section = CatalogSection.find(params[:id])
    @catalog_section.destroy

    respond_to do |format|
      format.html { redirect_to catalog_sections_url }
      format.json { head :no_content }
    end
  end
end
