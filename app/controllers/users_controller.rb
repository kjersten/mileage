class UsersController < ApplicationController

  # GET /users/new
  def new
    @user = User.new

    respond_to do |format|
      format.html # new.html.erb
    end
  end

  # POST /users
  def create
    @user = User.new(params[:user])

    respond_to do |format|
      if @user.save
         session[:user_id] = @user.id
        format.html { redirect_to root_url, notice: 'Your account has been created!'}
      else
        format.html { render action: "new" }
      end
    end
  end

  def show
    @user = User.find(session[:user_id]) if session[:user_id]
    if !@user
      redirect_to login_path
    end
  end

end