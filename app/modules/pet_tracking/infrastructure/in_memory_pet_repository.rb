require_relative "./pet_repository"

module PetTracking
    module Infrastructure
      class InMemoryPetRepository < Infrastructure::PetRepository
        def self.instance
          @instance ||= new
        end

        def initialize
          @pets = {}
          @next_id = 1
        end

        def pets
          @pets.values
        end


        def save(pet)
          pet.id = @next_id
          @pets[@next_id] = pet
          @next_id += 1
          pet
        end

        def find_by_id(id)
          @pets[id]
        end

        def find_outside_zone
          @pets.values.reject { |pet| pet.in_zone == "true" }
        end
      end
    end
end
