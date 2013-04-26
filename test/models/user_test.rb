require 'test_helper'

describe User do
  it "should have slug" do
    user = create(:user, name: 'Vega (Nico)')
    user.slug.must_equal 'vega-nico'
  end
end
