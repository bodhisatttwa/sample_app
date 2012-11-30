class UsersController < ApplicationController
  before_filter :signed_in_user, only: [:index, :edit, :update, :destroy]
  before_filter :correct_user, only: [:edit, :update]
  before_filter :admin_user, only: :destroy

  # HTTP: GET
  # URI: /users
  # Action: new
  def index
    #@users = User.all
    @users = User.paginate(page: params[:page])
  end

  # HTTP: GET
  # URI: /users/new
  # Action: new
  def new
    @user = User.new
  end

  # HTTP: GET
  # URI: /users/{id}
  # Action: create
  def show
    @user = User.find params[:id]
  end

  # HTTP: POST
  # URI: /users
  # Action: create
  def create
    @user = User.new(params[:user])
    if @user.save
      sign_in @user
      flash[:success]="Welcome to the Sample App!"
      redirect_to @user
    else
      render 'new'
    end
  end

  # HTTP: GET
  # URI: /users/{id}/edit
  # Action: edit
  def edit
    #@user = User.find(params[:id])
  end

  # HTTP: PUT
  # URI: /users/{id}
  # Action: update
  def update
    #@user = User.find(params[:id])
    if @user.update_attributes(params[:user])
      flash[:success]="Profile updated!"
      sign_in @user
      redirect_to @user
    else
      render 'edit'
    end
  end

  # HTTP: DESTROY
  # URI: /users/{id}
  # Action: delete
  def destroy
    User.find(params[:id]).destroy
    flash[:success] = "User destroyed."
    redirect_to users_url
  end

  private
  def signed_in_user
    unless signed_in?
      store_location
      flash[:notice] = "Please sign in."
      redirect_to signin_url
    end
    # equivalent shortcut
    #redirect_to signin_url, notice: "Please sign in." unless signed_in?
  end

  def correct_user
    @user = User.find(params[:id])
    redirect_to(root_path) unless current_user?(@user)
  end

  def admin_user
    redirect_to(root_path) unless current_user.admin?
  end
end
