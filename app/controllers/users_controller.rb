class UsersController < ApplicationController
 before_action :logged_in_user, only: [:index, :edit, :update, :destroy]
 before_action :correct_user,   only: [:edit, :update]
 before_action :admin_user, only: :destroy


  def index
    @users = User.where(activated: FILL_IN).paginate(page: params[:page])
  end



  def new
   #@user = User.find
   @user = User.new
  end

   def show
     redirect_to root_url and return unless FILL_IN
  end


  def create
    #previous code"
    #@user = User.new(params[:user])    # Not the final implementation!

    #then use user_params here then add a private method below
    @user = User.new(user_params)    # Not the final implementation!
    if @user.save
      @user.send_activation_email
      flash[:info] = "Please check your email to activate your account."
      redirect_to root_url
    else
      render 'new'
    end
  end


  def edit
    #@user = User.find(params[:id])
  end


  def update
    #@user = User.find(params[:id])
    if @user.update_attributes(user_params)
      flash[:success] = "Profile updated"
      redirect_to @user
    else
      render 'edit'
    end
  end

  def destroy
    User.find(params[:id].destroy)
    flash[:success] = "User deleted"
    redirect_to users_url
  end




private
  def admin_user
    redirect_to(root_url) unless current_user.admin?
  end


  def user_params

   params.require(:user).permit(:name, :email, :password,
                                   :password_confirmation)
  end


    def logged_in_user
      unless logged_in?
        store_location
        flash[:danger] = "Please log in."
        redirect_to login_url
      end
    end

    def correct_user
      @user = User.find(params[:id])
      redirect_to(root_url) unless @user == current_user
    end
end
