
admin = User.create(name: 'admin', email: 'admin@liki.cc', admin: true)
group = Group.create(name: 'LaPelícana')

Member.create(group: group, user: user)

Node.create(user: admin, group: group, title: 'Bienvenidxs')
