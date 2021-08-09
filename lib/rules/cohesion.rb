FF::Sys.new('Cohesion', priority: 50) do

  center_mass = [0.0,0.0]
  boids_count = FF::Cmp::Boids.each.to_a.count

  FF::Cmp::Boids.each do |boid|
    center_mass[0] += boid.x
    center_mass[1] += boid.y
  end

  FF::Cmp::Boids.each do |boid_update|
    move_boid = center_mass.dup
    move_boid[0] -= boid_update.x
    move_boid[1] -= boid_update.y
    move_boid[0] /= boids_count - 1.0
    move_boid[1] /= boids_count - 1.0

    boid_update.cx += (move_boid[0] - boid_update.x) / $cohesion
    boid_update.cy += (move_boid[1] - boid_update.y) / $cohesion
  end
end
