module PetTracking
    module Services
      class PetTrackingService
        def initialize(repository)
          @repository = repository
        end

        def pets_outside_zone_by_tracker_type
          pets = @repository.find_outside_zone
          {
            dogs: {
              small: pets.count { |pet| pet.pet_type == "dog" && pet.tracker_type == "small" },
              medium: pets.count { |pet| pet.pet_type == "dog" && pet.tracker_type == "medium" },
              big: pets.count { |pet| pet.pet_type == "dog" && pet.tracker_type == "big" }
            },
            cats: {
              small: pets.count { |pet| pet.pet_type == "cat" && pet.tracker_type == "small" },
              big: pets.count { |pet| pet.pet_type == "cat" && pet.tracker_type == "big" }
            }
          }
        end
      end
    end
end
