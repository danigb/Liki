require 'test_helper'

describe Tagging do
  it 'have tag and tagged' do
    p = create(:node)
    c = create(:node)
    t = Tagging.create!(tag: p, tagged: c)
    t.tag.must_equal p
    t.tagged.must_equal c
    p.taggings.count.must_equal 1
    p.taggings_count.must_equal 1
    p.taggeds.must_include c
  end

  it 'have position' do
    tag = create(:node)
    t1 = Tagging.create!(tag: tag, tagged: create(:node))
    t2 = Tagging.create!(tag: tag, tagged: create(:node))
    t1.position.must_equal 1
    t2.position.must_equal 2
  end
end
