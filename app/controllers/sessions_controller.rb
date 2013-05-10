class SessionsController < ApplicationController
  def new
    m = Member.find_by_auth_token(params[:id])
    if m 
      session[:space_id] = m.space.id
      m.update_attributes(last_login_at: Time.now, 
                               login_count: m.login_count + 1)
      self.current_user = m.user.id
      redirect_to root_path
    end
  end

  def user_level
    session[:current_user_level] = params[:id]
    redirect_to root_path
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

end
