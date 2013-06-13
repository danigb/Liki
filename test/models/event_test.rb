require 'test_helper'

describe Event do
  it 'finds in month' do
    before_event = create(:event, date: Date.civil(2010, 9, 3))
    event = create(:event, date: Date.civil(2010, 10, 3))
    after_event = create(:event, date: Date.civil(2010, 11, 3))
    month = Event.in_month(2010, 10)
    month.wont_include before_event
    month.must_include event
    month.wont_include after_event
  end
end
