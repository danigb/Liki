class SpaceImageUploader < ImageUploader
  # Override the filename of the uploaded files:
  # Avoid using model.id or version_name here, 
  # see uploader/store.rb for details.
  def filename
    "#{model.name.parameterize}-bg.#{model.background_image.file.extension}" if original_filename
  end
end
