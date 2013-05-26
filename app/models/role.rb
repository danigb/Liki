class Role
  attr_accessor :name, :partial, :children, :children_types

  def initialize(name)
    @name = name
    @partial = name
    @children_types = []
    @children  = Proc.new {|n| n.children }
  end

  def self.find(name)
    name ||= ''
    key = name.to_s.downcase.to_sym
    ROLES[key] || ROLES[:default]
  end

  ROLES = {}
  ROLES[:default] = Role.new('default')

  ROLES[:folder] = Role.new('folder')

  ROLES[:slides] = Role.new('slides').tap do |role|
    role.children_types << 'photo' 
    role.children = Proc.new do |node|
      node.children.reorder('created_at DESC') 
    end
  end

  ROLES[:photos] = Role.new('photos').tap do |role|
    role.children_types << 'photo' 
    role.partial = :slides
    role.children = Proc.new do |node|
      node.space.nodes.where(role: 'photo').reorder('created_at DESC') 
    end
  end

  ROLES[:download] = Role.new('download')

  ROLES[:page] = Role.new('page').tap do |role|
    role.partial = :folder
    role.children_types << 'section' 
  end
end
