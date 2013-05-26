class NodeImageUploader < ImageUploader
  # Override the filename of the uploaded files:
  # Avoid using model.id or version_name here, 
  # see uploader/store.rb for details.
  def filename
    name = model.title.present? ? 
      model.title.parameterize : Time.now.to_i.to_s
    space = model.space.name.parameterize
    "#{space}-#{name}.#{model.image.file.extension}" if original_filename
  end
end
