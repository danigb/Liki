class UploadWorker 
  include Sidekiq::Worker

  def perform(id)
    node = Node.find(id)
    if node.image.url.blank?
      node.remote_image_url = options[:dropbox] if options[:dropbox]
      node.save
    end
  end
end
