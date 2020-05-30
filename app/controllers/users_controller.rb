class UsersController < ApplicationController
  rescue_from ActiveRecord::RecordNotFound, with: :catch_not_found
  before_action :set_user, only: [:show, :edit, :update, :destroy]
  layout 'user_layout' #this will check for flash alerts

  def index
    @users = User.all
    render template: "users/index.html.erb"
  end

  def new
    @user=User.new
  end

  def create
    #@user= User.new(params[:user])
    @user = User.new(user_params)
    if @user.save
      flash[:notice] = "You signed up successfully!"
      flash[:color] = "valid"
      #redirect_to @user\
      render :show
    else
      flash[:notice] = " user or password was not correct. Please try again"
      flash[:color] = "invalid"
      render :new
    end
    #render :new
  end

  def edit
  end
  def update
    if @user.update(user_params) #if this returns not nill values, then it is success
      flash.notice = "The user record was created successfully."
      redirect_to @user
    else
      flash.now.alert =@user.errors.full_messages.to_sentence
      render :edit
    end
  end

  def show
  end

  def destroy
    @user.destroy
    flash.notice = "The user record was erased successfully."
    redirect_to users_path
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_user
      @user = User.find(params[:id])
    end

    # Only allow a lists of trusted parameters through.
    def user_params
      params.require(:user).permit(:name, :email, :password)
    end

    def catch_not_found(e)
      Rails.logger.debug("We had a not found exception.")
      flash.alert = e.to_s
      redirect_to users_path
    end

end
