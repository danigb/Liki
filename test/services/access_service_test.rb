require 'test_helper'

describe AccessService do
  let(:node) { create(:node) }
  let(:user) { create(:user) }
  let(:service) { AccessService.new(user) }

  it "can't view node if not user" do
    access = AccessService.new(nil).view?(node)
    access.must_be :denied?
    access.cause.must_equal :user_required
  end

  it "can't view node if not member" do
    access = service.view?(node)
    access.must_be :denied?
    access.cause.must_equal :member_required
  end

  it 'can view node if member' do
    node.space.add_member(user)

    access = service.view?(node)
    access.wont_be :denied?
  end
end
