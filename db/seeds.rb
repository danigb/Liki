
class SiteInitializer
  def initialize
    @admin = User.create(name: 'Admin', admin: true)
    @liki = Group.create(name: 'Liki', user: @admin)
    @group = Group.create(name: 'La Pelícana', user: @admin)
    Member.create(user: @admin, group: @group)
    add_group_nodes('¿Cómo funciona?', 'Chiquillería', 'Madres y padres', 'Bibliografía', 'Teoría')
    add_users('Dani', 'Vega', 'Sandra', 'Paula', 'Nani', 'Anna', 'Marcos', 'Roberto')
  end

  def add_group_nodes(*args)
    args.each do |title|
      Node.create(title: title, user: @admin, parent: @group.node)
    end
  end

  def add_users(*args)
    who = @group.nodes.find('madres-y-padres')
    args.each do |name|
      user = User.create(name: name)
      member = Member.create(user: user, group: @group)
      member.node.update_attributes(parent_id: who.id)
    end
  end
end

SiteInitializer.new

