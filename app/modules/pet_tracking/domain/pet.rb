module PetTracking
    module Domain
      class Pet
        attr_accessor :pet_type, :tracker_type, :owner_id, :in_zone, :lost_tracker, :id

        VALID_PET_TYPES = %w[dog cat].freeze
  
        def initialize(tracker:, owner_id:, in_zone:, lost_tracker: nil)
          self.owner_id = owner_id
          self.pet_type = tracker.pet_type
          self.tracker_type = tracker.tracker_type
          self.in_zone = in_zone
          self.lost_tracker = (pet_type == 'cat' ? lost_tracker : nil)
          validate!
        end

        private 

        def validate!
          raise ArgumentError, "Invalid pet type: #{pet_type}" unless VALID_PET_TYPES.include?(pet_type)
          raise ArgumentError, 'lost_tracker is only valid for cats' if lost_tracker && pet_type != 'cat'
        end
      end
    end
end
