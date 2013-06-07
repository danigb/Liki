module HasCurrentSpace
  extend ActiveSupport::Concern

  included do
    helper_method :current_space
  end

  if Rails.env.test?
    def current_space
      Space.first
    end
  else
    def current_space
      @current_space = Space.find_by_host request.env['HTTP_HOST']
      if @current_space
        session[:space_id] = @current_space.id
      else
        session[:space_id] ||= 2
      end
      @current_space ||= Space.find session[:space_id]
    end
  end
end
