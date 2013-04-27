
admin = User.create(name: 'admin', email: 'admin@liki.cc', admin: true)
group = Group.create(name: 'LaPelícana')

Member.create(group: group, user: admin)

node = Node.create(user: admin, group: group, title: 'Bienvenidxs')
group.node = node
group.save
