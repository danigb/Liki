require 'test_helper'

describe NotifyMailer do
  let(:space) { create(:space, host: 'test.es') }
  let(:node) { create(:node, space: space) }
  let(:user) { create(:user) }

  it 'send node created to space follower' do
    send_email :space_follower_node_created
  end

  it 'send node update to space follower' do
    send_email :space_follower_node_updated
  end

  it 'send children node created to follers' do
    node.parent = create(:node)
    send_email :children_node_created
  end
  
  it 'send image tag created' do
    photo = create(:photo)
    tag = photo.tag(node)
    email = NotifyMailer.photo_tag_created(user, tag).deliver
    delivered?(email)
  end

  def send_email(method)
    email = NotifyMailer.send(method, user, node).deliver
    delivered?(email)
  end

  def delivered?(email)
    ActionMailer::Base.deliveries.wont_be :empty?
    email.to.must_include user.email
    email
  end


end
