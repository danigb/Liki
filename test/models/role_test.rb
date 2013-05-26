require 'test_helper'

describe Role do
  it 'finds default' do
    role = Role.find(nil)
    role.must_be :present?
    puts role
    role.name.must_equal 'Role::DefaultRole'
  end

  it 'finds slides' do
    role = Role.find('Slides')
    role.name.must_equal 'Role::Slides'
  end
end
