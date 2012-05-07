class PagePluginRelationsController < ApplicationController
  # GET /page_plugin_relations
  # GET /page_plugin_relations.json
  def index
    @page_plugin_relations = PagePluginRelation.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @page_plugin_relations }
    end
  end

  # GET /page_plugin_relations/1
  # GET /page_plugin_relations/1.json
  def show
    @page_plugin_relation = PagePluginRelation.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @page_plugin_relation }
    end
  end

  # GET /page_plugin_relations/new
  # GET /page_plugin_relations/new.json
  def new
    @page_plugin_relation = PagePluginRelation.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @page_plugin_relation }
    end
  end

  # GET /page_plugin_relations/1/edit
  def edit
    @page_plugin_relation = PagePluginRelation.find(params[:id])
  end

  # POST /page_plugin_relations
  # POST /page_plugin_relations.json
  def create
    @page_plugin_relation = PagePluginRelation.new(params[:page_plugin_relation])

    respond_to do |format|
      if @page_plugin_relation.save
        format.html { redirect_to @page_plugin_relation, notice: 'Page plugin relation was successfully created.' }
        format.json { render json: @page_plugin_relation, status: :created, location: @page_plugin_relation }
      else
        format.html { render action: "new" }
        format.json { render json: @page_plugin_relation.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /page_plugin_relations/1
  # PUT /page_plugin_relations/1.json
  def update
    @page_plugin_relation = PagePluginRelation.find(params[:id])

    respond_to do |format|
      if @page_plugin_relation.update_attributes(params[:page_plugin_relation])
        format.html { redirect_to @page_plugin_relation, notice: 'Page plugin relation was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @page_plugin_relation.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /page_plugin_relations/1
  # DELETE /page_plugin_relations/1.json
  def destroy
    @page_plugin_relation = PagePluginRelation.find(params[:id])
    @page_plugin_relation.destroy

    respond_to do |format|
      format.html { redirect_to page_plugin_relations_url }
      format.json { head :no_content }
    end
  end
end