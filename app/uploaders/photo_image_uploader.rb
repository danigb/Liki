class PhotoImageUploader < ImageUploader
  def filename
    if original_filename
      space = model.space.name.parameterize
      "#{space}-#{Time.now.to_i}.#{model.image.file.extension}" 
    end
  end
end
