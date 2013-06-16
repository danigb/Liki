class MentionWorker
  include Sidekiq::Worker
  sidekiq_options retry: false

  def perform
    Node.where(mentions_solved: false).find_each do |node|
      MentionService.update_mentions(node)
    end
  end
end
