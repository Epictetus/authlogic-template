class UsersController < ApplicationController
  before_filter :require_no_user, :only => [:new, :create]
  before_filter :require_user, :except => [:new, :create]
  
  def index
    @users = User.all
  end

  def show
    @user = @current_user
  end

  def new
    @user = User.new
  end

  def edit
    @user = @current_user
  end

  def create
    @user = User.new(params[:user])
    if @user.save
      flash[:notice] = 'ユーザを新規作成しました。'
      redirect_back_or_default user_url
    else
      render :action => "new"
    end
  end

  def update
    @user = @current_user
    if @user.update_attributes(params[:user])
      flash[:notice] = 'ユーザを更新しました。'
      redirect_back_or_default user_url
    else
      render :action => "edit"
    end
  end

  def destroy
    @user = @current_user
    @user.destroy
    redirect_to(users_url)
  end
end
