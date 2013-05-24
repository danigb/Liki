require 'test_helper'

describe Role do
  it 'finds default' do
    role = Role.find(nil)
    role.must_be :present?
    role.name.must_equal 'default'
  end

  it 'finds slides' do
    role = Role.find('Slides')
    role.name.must_equal 'slides'
  end
end
