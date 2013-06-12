module HasPrototype
  extend ActiveSupport::Concern

  included do
    belongs_to :prototype, counter_cache: true
  end

  def proto
    unless @proto
      @proto = self.prototype ? self.prototype : 
        self.space.default_prototype
      @proto.node = self
    end
    @proto
  end

end
