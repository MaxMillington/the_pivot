class SessionsController < ApplicationController
  include ApplicationHelper
  
  def new
  end

  def create
    user = User.find_by(email: params[:session][:email])
    if user && user.authenticate(params[:session][:password])
      session[:user_id] = user.id
      flash[:success] = "Welcome back to Collector's World, #{user.first_name}" \
        " #{user.last_name}!"
        if platform_admin?
          redirect_to platform_admin_dashboard_path
        elsif seller_admin?
          redirect_to seller_admin_dashboard_path(user.seller.slug)
        else
          redirect_to profile_path
        end
    else
      flash[:warning] = "Unable to Login with this Email and" \
        " Password combination."
      render :new
      end
  end


  def destroy
    session[:user_id] = nil
    redirect_to root_path
  end
end
