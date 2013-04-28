class SessionsController < ApplicationController
  def new
    m = Member.find_by_auth_token(params[:id])
    if m 
      session[:user_id] = m.user.id
      session[:group_id] = m.group.id
      m.update_attributes(last_login_at: Time.now, 
                               login_count: m.login_count + 1)
      redirect_to root_path
    end
  end

  def enter
    session[:user_id] = params[:id]
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

end
