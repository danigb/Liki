class Role
  attr_accessor :name, :node, 
    :partial, :form, :children_types

  def initialize(name, node)
    @name = name
    @node = node
    @partial = name
    @form = 'default'
    @children_types = []
  end

  def children
    @node.children
  end

  def build(role)
    @node.children.build(role: role, prevent_slug_creation: true)
  end

  def self.find(role)
    @roles ||= Role.descendants.map &:name
    role ||= ''
    name = "Role::#{role.camelcase}"
    @roles.include?(name) ? name.constantize : Role::DefaultRole
  end

  class DefaultRole < Role
    def initialize(node)
      super('default', node)
    end
  end

  class Folder < Role
    def initialize(node)
      super('folder', node)
    end
  end

  class Slides < Role
    def initialize(node)
      super('slides', node)
      self.children_types << 'photo'
    end

    def children
      @node.children.reorder('created_at DESC')
    end

  end

  class Photos < Role
    def initialize(node)
      super('photos', node)
      self.partial = :slides
      self.children_types << 'photo'
    end

    def children
      node.space.nodes.where(role: 'photo').reorder('created_at DESC') 
    end
  end

  class Section < Role
    def initialize(node)
      super('section', node)
      self.partial = 'default'
      self.form = 'section'
    end
  end

  class Download < Role
    def initialize(node)
      super('download', node)
    end
  end

  class Page < Role
    def initialize(node)
      super('page', node)
      self.partial = :folder
      self.children_types << 'section'
    end
  end

  class Profile < Role
    def initialize(node)
      super('profile', node)
      self.children_types << 'photo'
      self.children_types << 'section'
    end
  end
end
