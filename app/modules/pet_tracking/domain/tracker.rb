module PetTracking
    module Domain
      class Tracker
        attr_accessor :tracker_type, :pet_type

        VALID_TRACKER_TYPES = { "dog" => %w[small medium big], "cat" => %w[small big] }.freeze

        def initialize(tracker_type:, pet_type:)
          self.tracker_type = tracker_type
          self.pet_type = pet_type
          validate!
        end

        def ==(other)
          tracker_type == other.tracker_type && pet_type == other.pet_type
        end

        private

        def validate!
          raise ArgumentError, "Invalid tracker type: #{tracker_type} for #{pet_type}" unless VALID_TRACKER_TYPES[pet_type].include?(tracker_type)
        end
      end
    end
end
