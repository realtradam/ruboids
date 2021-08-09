FF::Sys.new('Target', priority: 50) do
  FF::Cmp::Boids.each do |boid|
    boid.cx += ($x_target - boid.x) / $target_strength
    boid.cy += ($y_target - boid.y) / $target_strength
  end
end
