# This special function is already called by apply_boid_calculations.rb
# do not add or call this function elsewhere
FF::Sys.new('Limit') do
  unless $config.limit < 0
    FF::Cmp::Boids.each do |boid|
      if boid.entities[0].components[FF::Cmp::Piranha].nil?
        multi = 1.0
      else
        multi = 0.3
      end

      absolute_velocity = Math.sqrt((boid.vx**2) + (boid.vy**2))
      if absolute_velocity > $config.limit
        boid.vx = (boid.vx / absolute_velocity) * $config.limit * multi
        boid.vy = (boid.vy / absolute_velocity) * $config.limit * multi
      end
    end
  end
end
