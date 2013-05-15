require 'test_helper'

describe NotifyMailer do

  it 'send node created to space follower' do
    send_email :space_follower_node_created
  end

  it 'send node update to space follower' do
    send_email :space_follower_node_updated
  end

  it 'send children node created to follers' do
    send_email :children_node_created
  end

  def send_email(method)
    user = create(:user)
    node = create(:node, parent: create(:node))
    email = NotifyMailer.send(method, user, node).deliver
    ActionMailer::Base.deliveries.wont_be :empty?
    email.to.must_include user.email
    email
  end


end
