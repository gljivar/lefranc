class GroupsController < ApplicationController
  
  # GET /groups
  # GET /groups.json
  def index
    @groups = Group.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @groups }
    end
  end

  def show
    @group = Group.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @group }
    end
  end

  def new
    @group = Group.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @group }
    end
  end

  def edit
    @group = Group.find(params[:id])
  end

  def create
    #TODO: Perhaps policy that user automatically becomes group's user should perhaps be placed in model
    @group = Group.new(params[:group])
    @group.user = current_user

    respond_to do |format|
      if @group.save
        @group_user = GroupUser.new
        @group_user.user_id = current_user.id
        @group_user.group_id = @group.id
        if @group_user.save
          format.html { redirect_to @group, :notice => 'Group was successfully created.' }
          format.json { render json: @group, status: :created, location: @group }
        else
          format.html { redirect_to groups_path, :notice => 'Group was successfully created, but joining to the group failed. Please join manually or send us a report about what happened.' }
          format.json { render json: @group_user.errors, status: :unprocessable_entity }
        end
      else
        format.html { render action: "new" }
        format.json { render json: @group.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    @group = Group.find(params[:id])

    respond_to do |format|
      if @group.update_attributes(params[:group])
        format.html { redirect_to @group, :notice => 'Group was was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @group.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @group = Group.find(params[:id])
    @group.destroy

    respond_to do |format|
      format.html { redirect_to groups_url }
      format.json { head :no_content }
    end
  end

  private


end
