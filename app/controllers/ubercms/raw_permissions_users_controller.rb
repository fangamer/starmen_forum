class Ubercms::RawPermissionsUsersController < UbercmsController
  before_action :require_user

  def create
    @raw_permissions_user = @user.raw_permissions_users.create(raw_permissions_user_params)
    if !@raw_permissions_user.new_record?
      flash[:success] = "RawPermissionsUser Saved"
      redirect_to edit_ubercms_user_path(@user)
    else
      flash.now[:danger] = "Error Saving RawPermissionsUser"
      redirect_to edit_ubercms_user_path(@user)
    end
  end

  def destroy
    @raw_permissions_user = @user.raw_permissions_users.find(params[:id])
    if !@raw_permissions_user.destroy
      flash[:success] = "RawPermissionsUser Destroyed"
      redirect_to edit_ubercms_user_path(@user)
    else
      flash.now[:danger] = "Error Destroying RawPermissionsUser"
      redirect_to edit_ubercms_user_path(@user)
    end
  end

private
  def raw_permissions_user_params
    params[:raw_permissions_user].permit(:raw_permission_id,:individual_id,:value)
  end

  def require_user
    @user = User.find(params[:user_id])
  end
end
