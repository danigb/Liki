class Workers
  def self.push(klass, *args)
    if Rails.env.production?
      klass.perform_async(*args)
    else
      klass.new.perform(*args)
    end
  end
end
