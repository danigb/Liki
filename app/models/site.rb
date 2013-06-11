module Site
  def default_prototype
    @proto = Prototype.first || Prototype.create!(name: 'Página')
  end
   
  extend self
end
