class UploadWorker 
  include Sidekiq::Worker

  def perform(id)
    node = Node.where(id: id).first
    if node && node.image.url.blank? && node.dropbox_image_url.present?
      node.remote_image_url = node.dropbox_image_url
      node.save
    end
  end
end
