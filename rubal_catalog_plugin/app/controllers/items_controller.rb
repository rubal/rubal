class ItemsController < ApplicationController
  before_filter :only => [:new, :create, :browse_section] do
    @selected_section = nil
    unless params[:section_key].blank?
      params[:section_key] = params[:section_key].downcase
      begin
        @selected_section = CatalogSection.find_by_key(params[:section_key])
        @selected_section ||= CatalogSection.find(params[:section_key])
      rescue
        @selected_section = nil
      end
    end
  end

  # GET /items
  # GET /items.json
  def index
    @sections = []
    CatalogSection.all.each do |cs|
      @sections.push({:name => cs.name, :key => (cs.key.blank?) ? cs.id : cs.key, :items => Item.find_all_by_section_id(cs.id)})
    end

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @items }
    end
  end

  # GET /items/1
  # GET /items/1.json
  def show
    @item = Item.find(params[:id])
    @photos = ItemPhoto.find_all_by_item_id(@item.id)
    @photos ||= []
    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @item }
    end
  end

  # GET /items/new
  # GET /items/new.json
  def new
    @item = Item.new
    4.times do
      @item.photos.build
    end

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @item }
    end
  end

  # GET /items/1/edit
  def edit
    @item = Item.find(params[:id])

    4.times do
      @item.photos.build
    end
  end

  # POST /items
  # POST /items.json
  def create
    @item = Item.new(params[:item])
    save_success = @item.save

    respond_to do |format|
      if save_success
        format.html { redirect_to @item, notice: 'Item was successfully created.' }
        format.json { render json: @item, status: :created, location: @item }
      else
        format.html { render action: "new" }
        format.json { render json: @item.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /items/1
  # PUT /items/1.json
  def update
    @item = Item.find(params[:id])
    save_success = @item.update_attributes(params[:item])

    respond_to do |format|
      if save_success
        format.html { redirect_to @item, notice: 'Item was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @item.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /items/1
  # DELETE /items/1.json
  def destroy
    @item = Item.find(params[:id])
    @item.destroy

    respond_to do |format|
      format.html { redirect_to items_url }
      format.json { head :no_content }
    end
  end

  def browse_all
    @sections = CatalogSection.all
    @sections = []
    CatalogSection.all.each do |cs|
      if (Item.find_all_by_section_id(cs.id).count > 0)
        @sections.push({:name => cs.name, :key => (cs.key.blank?) ? cs.id : cs.key, :items => Item.find_all_by_section_id(cs.id)})
      end
    end

    rubal_render params[:url]
  end

  def browse_section
    logger.debug "\033[0;34m#{@selected_section.to_s}\033[0;37m"
    logger.debug " that's what we found"
  end
end
