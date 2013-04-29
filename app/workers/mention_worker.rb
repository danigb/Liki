class MentionWorker
  include Sidekiq::Worker

  def perform
    Node.where(mentions_solved: false).find_each do |node|
      NodeService.update_mentions(node)
    end
  end
end
