class SessionsController < ApplicationController
  def new
    m = Member.find_by_auth_token(params[:id])
    if m 
      session[:group_id] = m.group.id
      m.update_attributes(last_login_at: Time.now, 
                               login_count: m.login_count + 1)
      self.current_user = m.user.id
      redirect_to root_path
    end
  end

  def enter
    self.current_user = params[:id]
    redirect_to root_path
  end

  def visit
    session[:group_id] = params[:id]
    redirect_to root_path
  end

  def destroy
    session[:user_id] = nil
    redirect_to root_path
  end

  def send_token
    @user = User.find_by_email params[:email] if params[:email].present?
    @member = current_group.member(@user)
    if @member
      @member.generate_auth_token
      @member.save
      UserMailer.auth_token_email(@member).deliver
    end
  end

end
