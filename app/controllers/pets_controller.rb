require_relative "../../app/modules/pet_tracking/infrastructure/in_memory_pet_repository"
require_relative "../../app/modules/pet_tracking/services/pet_tracking_service"
require_relative "../../app/modules/pet_tracking/domain/pet"
require_relative "../../app/modules/pet_tracking/domain/tracker"

class PetsController < ApplicationController
    class << self
        def repository
          @repository ||= PetTracking::Infrastructure::InMemoryPetRepository.new
        end
    end


      def create
        pet = PetTracking::Domain::Pet.new(
          tracker: PetTracking::Domain::Tracker.new(
            tracker_type: params[:tracker_type],
            pet_type: params[:pet_type]
          ),
          owner_id: params[:owner_id],
          in_zone: params[:in_zone],
          lost_tracker: params[:lost_tracker]
        )

        self.class.repository.save(pet)

      rescue StandardError => e
        render json: { message: e.message }, status: :unprocessable_entity
      else
        render json: { message: "Pet created", pets: self.class.repository.pets }, status: :created
      end

      def outside_zone
        service = PetTracking::Services::PetTrackingService.new(self.class.repository)
        result = service.pets_outside_zone_by_tracker_type
        puts result
        render json: result, status: :ok
      end
end
