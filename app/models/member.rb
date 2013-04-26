require 'securerandom'

class Member < ActiveRecord::Base
  belongs_to :user
  belongs_to :group, counter_cache: true

  validates_presence_of :user_id, :group_id
  validates_presence_of :auth_token, :auth_token_created_at
  validates_uniqueness_of :user_id, scope: :group_id

  before_validation :generate_auth_token

  def generate_auth_token
    if self.auth_token.blank?
      self.auth_token = SecureRandom.urlsafe_base64(30)
      self.auth_token_created_at = Time.now
    end
  end
end
