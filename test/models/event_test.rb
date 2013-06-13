require 'test_helper'

describe Event do
  it 'finds in month' do
    space = create(:space)
    before_event = evt(space, 2010, 9, 3)
    event = evt(space, 2010, 10, 3)
    after_event = evt(space, 2010, 11, 3)
    month = Event.month_scope(space.events, 2010, 10)
    month.wont_include before_event
    month.must_include event
    month.wont_include after_event
  end

  protected
  def evt(space, year, month, day)
    create(:event, space: space,
           date: Date.civil(2010, 9, 3))
  end
end
