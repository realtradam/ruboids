FF::Sys.new('Alignment', priority: 50) do
  group_velocity = [0.0,0.0]
  boids_count = FF::Cmp::Boids.each.to_a.count

  FF::Cmp::Boids.each do |boid|
    group_velocity[0] += boid.vx
    group_velocity[1] += boid.vy
  end

  FF::Cmp::Boids.each do |boid_update|
    move_boid = group_velocity.dup
    move_boid[0] -= boid_update.vx
    move_boid[1] -= boid_update.vy
    move_boid[0] /= boids_count - 1.0
    move_boid[1] /= boids_count - 1.0

    boid_update.cx += (move_boid[0] - boid_update.vx) / $alignment
    boid_update.cy += (move_boid[1] - boid_update.vy) / $alignment
  end
end
