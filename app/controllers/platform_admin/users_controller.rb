class PlatformAdmin::UsersController < ApplicationController

  def index
    @users = User.all
  end

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)

    if @user.save
      session[:user_id] = @user.id
      @user.send_creation_email
      flash[:success] = "Successfully Created Seller Admin," \
        " #{@user.first_name} #{@user.last_name}!"
      @user.roles << Role.find_by(name: "seller_admin")
      redirect_to platform_admin_dashboard_path
    else
      flash.now[:warning] = @user.errors.full_messages.join(". ")
      render :new
    end
  end

  def destroy
    @user = User.find(params[:id])
    @user.destroy
    flash[:success] = "Successfully deleted user."
    redirect_to platform_admin_dashboard_path
  end


  private

  def user_params
    params.require(:user)
        .permit(:first_name, :last_name,
                :email, :password, :seller_id)
  end

end
