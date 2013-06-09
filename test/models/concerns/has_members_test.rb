require 'test_helper'

class HasMembersTest < ActiveSupport::TestCase
  let(:space) { create(:space) }
  let(:user) { create(:user) }

  it 'can add member' do
    member = space.add_member(user)
    member.must_be :present?
    Member.count.must_equal 1
    Member.first.must_equal member
  end

  it "can't add member twice" do
    m = space.add_member(user)
    space.add_member(user).must_equal m
  end

  it 'adds member if space is open' do
    space.member(user).must_be :blank?
    space.is_open = true
    space.member(user).must_be :present?
  end
end

