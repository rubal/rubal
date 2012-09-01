class PermissionsController < ApplicationController
  # GET /permissions
  # GET /permissions.json
  def index
    @permissions = Permission.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @permissions }
    end
  end

  # GET /permissions/1
  # GET /permissions/1.json
  def show
    @permission = Permission.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @permission }
    end
  end

  # GET /permissions/new
  # GET /permissions/new.json
  def new
    @permission = Permission.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @permission }
    end
  end

  # GET /permissions/1/edit
  def edit
    @permission = Permission.find(params[:id])
  end

  # POST /permissions
  # POST /permissions.json
  def create
    @permission = Permission.new(params[:permission])

    respond_to do |format|
      if @permission.save
        format.html { redirect_to @permission, notice: 'Permission was successfully created.' }
        format.json { render json: @permission, status: :created, location: @permission }
      else
        format.html { render action: "new" }
        format.json { render json: @permission.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /permissions/1
  # PUT /permissions/1.json
  def update
    @permission = Permission.find(params[:id])

    respond_to do |format|
      if @permission.update_attributes(params[:permission])
        format.html { redirect_to @permission, notice: 'Permission was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @permission.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /permissions/1
  # DELETE /permissions/1.json
  def destroy
    @permission = Permission.find(params[:id])
    @permission.destroy

    respond_to do |format|
      format.html { redirect_to permissions_url }
      format.json { head :no_content }
    end
  end

  def edit_group_permissions
    @group = UserGroup.find_by_key(params[:group])
    @group_permissions_ids = @group.permission_ids
    @all_permissions = {}
    Permission.all.each do |p|
      pl_name = RubalCore::PluginManager.instance.get_name_by_substitution_name p.plugin_name
      if @all_permissions.include? pl_name
        @all_permissions[pl_name].push p
      else
        @all_permissions[pl_name] = [p]
      end
    end

  end

  def update_group_permissions
    @group = UserGroup.find(params[:user_group_id])
    @group.permission_ids= params[:user_group][:permission_ids]
    @group.save!
  end
end
