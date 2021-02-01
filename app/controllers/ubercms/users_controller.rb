class Ubercms::UsersController < UbercmsController
  def index
     @pagy, @users = pagy(User.order(id: :desc))
  end

  def edit
    @user = User.find(params[:id])
  end

  def update
    @user = User.find(params[:id])
    if @user.update(user_params)
      flash[:success] = "User Saved"
      redirect_to action: :index
    else
      flash.now[:danger] = "Error Saving User"
      render action: :edit
    end
  end

private
  def user_params
    params[:user].permit(:name,:email,:email_confirmed,:banned,:ban_reason)
  end
end
