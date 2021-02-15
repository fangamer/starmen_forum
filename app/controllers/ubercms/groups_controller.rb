class Ubercms::GroupsController < UbercmsController
  def index
    @pagy, @groups = pagy(Group.order(id: :desc))
  end

  def new
    @group = Group.new
  end

  def create
    @group = Group.create(group_params)
    if !@group.new_record?
      flash[:success] = "Group Saved"
      redirect_to action: :index
    else
      flash.now[:danger] = "Error Saving Group"
      render action: :new
    end
  end

  def edit
    @group = Group.find(params[:id])
    render action: :new
  end

  def update
    @group = Group.find(params[:id])
    if @group.update(group_params)
      flash[:success] = "Group Saved"
      redirect_to action: :index
    else
      flash.now[:danger] = "Error Saving Group"
      render action: :new
    end
  end

private
  def group_params
    params[:group].permit(:name)
  end
end
