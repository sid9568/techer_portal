class Teachers::SessionsController < ApplicationController

  def new
  end

  def create
    teacher = User.find_by(email: params[:email])
    if teacher&.authenticate(params[:password])
      session[:teacher_id] = teacher.id
      flash[:notice] = "Logged in successfully."
      redirect_to root_path
    else
      flash.now[:alert] = "Invalid email or password."
      render :new, status: :unprocessable_entity
    end
  end

  def destroy
    session[:teacher_id] = nil
    flash[:notice] = "Logged out successfully."
    redirect_to teachers_login_path
  end

end
