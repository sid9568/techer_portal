class Teachers::DashboardController < ApplicationController
  before_action :require_teacher_login
  protect_from_forgery with: :null_session

  def index
    @users = if params[:keyword].present?
      User.where(role:0).search_by_keyword(params[:keyword])
    else
      User.where(role:0)
    end
  end

  def create
    @user = User.find_by(full_name: params[:full_name], subject_name: params[:subject_name])
    if @user
      flash[:alert] = "A student with the same name and subject already exists."
      redirect_to root_path
    else
      @user = User.create!(
        full_name: params[:full_name],
        subject_name: params[:subject_name],
        marks: params[:marks],
        role: 0,
        password: "123456"
      )
      flash[:notice] = "User created successfully."
      redirect_to root_path
    end
  end


  def update
    @user = User.find_by_id(params[:id])
    @user.update!(full_name:params[:full_name], subject_name:params[:subject_name], marks: params[:marks], role: 0, password: "123456")
    redirect_to root_path
  end

  def destroy
    @user = User.find_by_id(params[:id])
    @user.destroy
    redirect_to root_path
  end

  private

  def require_teacher_login
    unless session[:teacher_id]
      flash[:alert] = "Please log in first."
      redirect_to teachers_login_path
    end
  end
end
