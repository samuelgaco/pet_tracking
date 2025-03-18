module PetTracking
    module Domain
      class Pet
        attr_reader :id

        def initialize(id:)
          self.id = id
        end
      end
    end
end
