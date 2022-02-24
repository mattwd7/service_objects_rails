module ServiceObjectsRails
  class << self
    def config
      yield self
    end
  end
end
