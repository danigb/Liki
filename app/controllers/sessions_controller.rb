class SessionsController < ApplicationController
  def new
    @session_form = SessionFormPresenter.new
    if create_session(service.authorize_token(params[:id]))
      render action: 'authorized' 
    end
  end

  def user_level
    session[:current_user_level] = params[:id]
    redirect_to root_path
  end

  def create
    @session_form = SessionFormPresenter.new(params[:session_form_presenter])
    if create_session(service.login(@session_form))
      path = params[:from].present? ? params[:from] : root_path
      redirect_to path, notice: 'Bienvenida'
    else
      flash.alert = 'Usuario o contraseña no válidas'
      render action: 'new'
    end
  end

  def enter
    self.current_user = params[:id]
    redirect_to root_path
  end

  def visit
    session[:space_id] = params[:id]
    redirect_to root_path
  end

  def destroy
    session[:user_id] = nil
    redirect_to root_path
  end

  def send_token
    @user = User.find_by_email params[:email] if params[:email].present?
    @member = current_space.member(@user)
    if @member
      @member.generate_auth_token
      @member.save
      UserMailer.auth_token_email(@member).deliver
    end
  end

  protected
  def create_session(user)
    return false unless user.present?
    self.current_user = user
  end

  def service
    @service ||= SessionService.new(current_space)
  end
end
