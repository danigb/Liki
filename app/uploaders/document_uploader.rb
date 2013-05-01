
class DocumentUploader < CarrierWave::Uploader::Base
  storage :file

  def store_dir
    "system/documents/"
  end

  def extension_white_list
    %w(pdf)
  end
end
