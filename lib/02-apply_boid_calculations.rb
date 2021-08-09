FF::Scn::BoidCalculations.add(FF::Sys.new('ApplyBoidCalculations', priority: 51) do
  FF::Cmp::Boids.each do |boid|
    boid.vx += boid.cx
    boid.vy += boid.cy
    boid.x += boid.vx
    boid.y += boid.vy
    #boid.obj.x = boid.obj.x
    #boid.vect.x1 = boid.obj.x + 7
    #boid.vect.y1 = boid.obj.y + 7
    #boid.vect.x2 = boid.obj.x + (boid.vx * 3) + 7
    #boid.vect.y2 = boid.obj.y + (boid.vy * 3) + 7
    boid.cx = 0
    boid.cy = 0
  end
end)
