FF::Scn::BoidCalculations.add(FF::Sys.new('ApplyBoidCalculations', priority: 75) do
  @center ||= Camera::Circle.new(color: [0.25,0.0,0.5,0.5],
                                 radius: 10,
                                 sectors: 10,
                                z: -49)
  @center_vel ||= Camera::Line.new(color: [0.25,0.0,0.5,0.5],
                                   width: 12,
                                  z: -50)
  unless $config.debug
    @center.remove
    @center_vel.remove
  end

  group_velocity = [0.0,0.0]
  center_mass = [0.0,0.0]
  boids_count = FF::Cmp::Boids.each.to_a.count

  FF::Cmp::Boids.each do |boid|
    boid.vx += boid.cx
    boid.vy += boid.cy
    FF::Sys::Limit.call
    boid.x += boid.vx
    boid.y += boid.vy

    boid.cx = 0.0
    boid.cy = 0.0


    center_mass[0] += boid.x
    center_mass[1] += boid.y
    group_velocity[0] += boid.vx
    group_velocity[1] += boid.vy
  end

  @center_vel.x1 = @center.x = (center_mass[0] / boids_count)
  @center_vel.y1 = @center.y = (center_mass[1] / boids_count)

  @center_vel.x1 += @center.radius
  @center_vel.y1 += @center.radius

  if $follow
    Camera.x = @center_vel.x1 = @center.x + @center.radius
    Camera.y = @center_vel.y1 = @center.y + @center.radius
  end
  @center_vel.x2 = @center_vel.x1 + ((group_velocity[0] / boids_count) * 10.0)
  @center_vel.y2 = @center_vel.y1 + ((group_velocity[1] / boids_count) * 10.0)
end)
