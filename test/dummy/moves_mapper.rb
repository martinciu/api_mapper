require "api_mapper"
require "virtus"
require "rom-mapper"

require "dummy/moves_mapper/entities/profile"
require "dummy/moves_mapper/entities/unit"
require "dummy/moves_mapper/entities/activity_type"
require "dummy/moves_mapper/entities/summary"
require "dummy/moves_mapper/entities/location"
require "dummy/moves_mapper/entities/place"
require "dummy/moves_mapper/entities/track_point"
require "dummy/moves_mapper/entities/activity"
require "dummy/moves_mapper/entities/segment"
require "dummy/moves_mapper/entities/day"

require "dummy/moves_mapper/mappers/profile_mapper"
require "dummy/moves_mapper/mappers/activity_type_mapper"
require "dummy/moves_mapper/mappers/summary_mapper"
require "dummy/moves_mapper/mappers/location_mapper"
require "dummy/moves_mapper/mappers/track_point_mapper"
require "dummy/moves_mapper/mappers/activity_mapper"
require "dummy/moves_mapper/mappers/place_mapper"
require "dummy/moves_mapper/mappers/segment_mapper"
require "dummy/moves_mapper/mappers/activity_mapper"
require "dummy/moves_mapper/mappers/day_mapper"

require "dummy/moves_mapper/router"

require "dummy/moves_mapper/summaries_repository"
require "dummy/moves_mapper/storylines_repository"

module DummyMovesMapper
  # Your code goes here...
end
