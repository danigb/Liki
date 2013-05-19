class UploadWorker 
  include Sidekiq::Worker

  def perform(id)
    node = Node.find(id)
    if node.image.url.blank?
      node.remote_image_url = node.dropbox_image_url
      node.save
    end
  end
end
