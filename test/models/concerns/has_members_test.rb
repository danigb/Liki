require 'test_helper'

class HasMembersTest < ActiveSupport::TestCase
  it 'can add member' do
    space = create(:space)
    user = create(:user)
    member = space.add_member(user)
    member.must_be :present?
    Member.count.must_equal 1
    Member.first.must_equal member
  end

  it "can't add member twice" do
    space = create(:space)
    user = create(:user)
    m = space.add_member(user)
    space.add_member(user).must_equal m
  end
end

