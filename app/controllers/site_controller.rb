class SiteController < ApplicationController
  def error404
    current_space.background_image.url = '/elmapa.jpg'
  end

  def error500
    current_space.background_image.url = '/lastripas.jpg'
  end

  def current_space
    @current_space ||= OpenStruct.new.tap do |space|
      space.background_image = OpenStruct.new
      space.name = ':-('
    end
  end

  def current_user
    nil
  end
end
