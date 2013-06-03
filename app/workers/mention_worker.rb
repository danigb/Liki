class MentionWorker
  include Sidekiq::Worker
  sidekiq_options :retry => false

  def perform
    Node.where(mentions_solved: false).find_each do |node|
      node.mentioner.update_mentions
    end
  end
end
