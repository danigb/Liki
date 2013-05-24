class Role
  attr_reader :name, :partial, :children
  def initialize(name, partial: nil, children: [])
    @name = name
    @partial = partial || name
    @children = children
  end

  def self.find(name)
    name ||= ''
    key = name.to_s.downcase.to_sym
    ROLES[key] || ROLES[:default]
  end

  ROLES = {}
  ROLES[:default] = Role.new('default')
  ROLES[:folder] = Role.new('folder')
  ROLES[:slides] = Role.new('slides', children: ['photo'])
  ROLES[:download] = Role.new('download')
  ROLES[:page] = Role.new('page', partial: :folder,
                          children: ['section'])
end
