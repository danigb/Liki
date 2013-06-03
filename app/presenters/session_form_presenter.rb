class SessionFormPresenter < FormPresenter
  attr_accessor :email, :password
  validates_presence_of :email, :password
  #validates_length_of :email, minimum: 4

end
