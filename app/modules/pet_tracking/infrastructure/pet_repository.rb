module PetTracking
    module Infrastructure
      class PetRepository
        def save(pet)
          raise NotImplementedError
        end

        def find_by_id(id)
          raise NotImplementedError
        end

        def find_by_owner_id(owner_id)
          raise NotImplementedError
        end

        def find_outside_zone
          raise NotImplementedError
        end
      end
    end
end
