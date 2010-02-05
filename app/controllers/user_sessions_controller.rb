class UserSessionsController < ApplicationController
  layout 'users'
  before_filter :require_no_user, :only => [:new, :create]
  before_filter :require_user, :only => :destroy

  def new
    @user_session = UserSession.new
  end

  # ログイン
  def create
    @user_session = UserSession.new(params[:user_session])
    if @user_session.save
      flash[:notice] = "ログインしました。"
      redirect_back_or_default user_url
    else
      flash[:notice] = "ログインに失敗しました。"
      render :action => :new
    end
  end

  # ログアウト
  def destroy
    current_user_session.destroy
    flash[:notice] = "ログアウトしました。"
    redirect_back_or_default new_user_session_url
  end
end
