class SiteController < ApplicationController
  def error404
    @background = '/lastripas2.jpg'
    render 'error404', layout: false
  end

  def error500
    @background = '/lastripas.jpg'
    render 'error500', layout: false
  end

  def access_denied

  end
end
