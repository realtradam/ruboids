FF::Scn::BoidCalculations.add(FF::Sys.new('Cohesion', priority: 50) do
  @center ||= Camera::Circle.new(color: [1,0.3,0.4,1],
                                 radius: 15,
                                 sectors: 10)

  center_mass = [0,0]
  boids_count = FF::Cmp::Boids.each.to_a.count

  FF::Cmp::Boids.each do |boid|
    center_mass[0] += boid.x
    center_mass[1] += boid.y
  end


  center_mass[0] #/= boids_count
  center_mass[1] #/= boids_count

  @center.x = (center_mass[0] / boids_count)
  @center.y = (center_mass[1] / boids_count)

  #Camera.x = center_mass[0] / boids_count
  #Camera.y = center_mass[1] / boids_count

  FF::Cmp::Boids.each do |boid_update|
    move_boid = center_mass.dup
    move_boid[0] -= boid_update.x
    move_boid[1] -= boid_update.y
    move_boid[0] /= boids_count - 1
    move_boid[1] /= boids_count - 1

    boid_update.cx += (move_boid[0] - boid_update.x) / 1000.0
    boid_update.cy += (move_boid[1] - boid_update.y) / 1000.0
  end
end)
