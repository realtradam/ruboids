# frozen_string_literal: true

FF::Sys.new('Bounds', priority: 50) do
  FF::Cmp::Boids.each do |boid|
    if boid.x > $config.xmax
      boid.cx -= $config.bounds_strength
    elsif boid.x < $config.xmin
      boid.cx += $config.bounds_strength
    end

    if boid.y > $config.ymax
      boid.cy -= $config.bounds_strength
    elsif boid.y < $config.ymin
      boid.cy += $config.bounds_strength
    end
  end
end
