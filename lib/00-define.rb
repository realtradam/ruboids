# frozen_string_literal: true

FF::Stg.add FF::Scn.new('Default')
FF::Scn.new('BoidCalculations')

FelFlame::Components.new('Boids',
                         # holds the object to render
                         #:obj,
                         # holds the vector to render
                         #:vect,
                         # the current position
                         x: 0, y: 0,
                         # current velocity
                         vx: 0, vy: 0,
                         # calculated velocity change for next frame
                         cx: 0, cy: 0,
                         flipped: false)
FelFlame::Components.new('Fish')
FF::Cmp::Fish.new
FelFlame::Components.new('Piranha')
FF::Cmp::Piranha.new
FelFlame::Components.new('BoidVisuals',
                         :obj, :vect)
