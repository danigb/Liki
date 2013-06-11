module HasPrototype
  extend ActiveSupport::Concern

  included do
    belongs_to :prototype
  end

  def proto
    unless @proto
      @proto = self.prototype ? self.prototype : Site.default_prototype
      @proto.node = self
    end
    @proto
  end

end
