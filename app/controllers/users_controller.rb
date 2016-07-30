class UsersController < ApplicationController
	before_action :not_login_user, only: [:show, :new, :create ]
  
	def index
    @users = User.all
  end


  def show
    @user = User.find(params[:id])
  end

  def new
    @user = User.new
    @signup = true
  end

  def create
    @user = User.new(user_params)
    if @user.save
      @user.activate!
      flash[:success] = "#{t('.successfully')}"
      respond_to do |format|
        format.html { redirect_to root_path }
        format.js
      end
    else
      respond_to do |format|
        format.html { render 'new' }
        format.js
      end
    end
  end
  def activate
    if (@user = User.load_from_activation_token(params[:id]))
      @user.activate!
      flash[:success] = "#{t('.activated')}"
      auto_login(@user)
    else
      not_authenticated
    end
  end
  
  def user_params
    params.require(:user).permit(:name, :email, :password,:password_confirmation)   
  end
  
  def not_login_user
    if logged_in? and !current_user
      redirect_to root_path
      flash[:warning] = "#{t('users.has_already_logged_in')}"
    end
  end
end
