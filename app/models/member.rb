require 'securerandom'

class Member < ActiveRecord::Base
  belongs_to :user
  belongs_to :node
  belongs_to :space, counter_cache: true

  validates_presence_of :user_id, :space_id
  validates_presence_of :auth_token, :auth_token_created_at
  validates_uniqueness_of :user_id, scope: :space_id

  before_validation :generate_auth_token
  after_create :create_member_node

  def generate_auth_token
    if self.auth_token.blank?
      self.auth_token = SecureRandom.urlsafe_base64(30)
      self.auth_token_created_at = Time.now
    end
  end

  protected
  def create_member_node
    self.node = Node.create!(title: user.name, 
                             user: self.user, 
                             space: self.space,
                             body: "Email: #{user.email}")
    self.save
  end
end
