require 'test_helper'

describe AccessService do
  let(:node) { create(:node) }
  let(:user) { create(:user) }
  let(:service) { AccessService.new(user) }
  
  describe 'SHOW OPEN SPACE' do
    it 'can view node if not user' do
      node.space.update_attributes(is_open: true)
      access = AccessService.new(nil).show(node)
      access.wont_be :denied?
    end
  end

  describe 'SHOW CLOSED SPACE' do
    it "can't view node if not user" do
      access = AccessService.new(nil).show(node)
      access.must_be :denied?
      access.cause.must_equal :user_required
    end

    it "can't view node if not member" do
      access = service.show(node)
      access.must_be :denied?
      access.cause.must_equal :member_required
    end

    it 'can view node if member' do
      node.space.add_member(user)

      access = service.show(node)
      access.wont_be :denied?
    end
  end

  describe 'EDIT' do
    it "can edit node if member" do
      node.space.add_member(user)
      access = service.update(node)
      access.wont_be :denied?
    end
  end
end
