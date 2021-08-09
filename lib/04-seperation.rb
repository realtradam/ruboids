FF::Scn::BoidCalculations.add(FF::Sys.new('Seperation', priority: 50) do
  FF::Cmp::Boids.each do |boid_update|
    newvec = [0,0]
    FF::Cmp::Boids.each do |boid_check|
      next if boid_check == boid_update
      if Math.sqrt(((-boid_check.x + boid_update.x)**2) + ((-boid_check.y + boid_update.y)**2)).abs < 200
        puts 'repelling'
        newvec[0] -= boid_check.x - boid_update.x 
        newvec[1] -= boid_check.y - boid_update.y 
      end
    end
    boid_update.cx += newvec[0] / 100.0
    boid_update.cy += newvec[1] / 100.0
  end
  puts 'end of frame'
end)
