FF::Sys.new('Target', priority: 50) do

  FF::Cmp::Fish[0].entities.each do |ent|
    farthest = []
    boid = ent.component[FF::Cmp::Boids].first
    FF::Cmp::Piranha[0].entities.each do |_piranha|
      piranha = _piranha.component[FF::Cmp::Boids].first
      if farthest[0].nil? || Math.sqrt(((boid.x - piranha.x)**2) + ((boid.y + piranha.y)**2)).abs < farthest[0]
        farthest[0] = Math.sqrt(((boid.x - piranha.x)**2) + ((boid.y + piranha.y)**2)).abs
        farthest[1] = piranha
      end
    end
    boid.cx -= (2 * (piranha.x - boid.x) / $config.target_strength)
    boid.cy -= (2 * (piranha.y - boid.y) / $config.target_strength)
  end

 # FF::Cmp::Piranha[0].entities.each do |ent|
 #   boid = ent.components[FF::Cmp::Boids].first
 #   boid.cx += ($config.target_x - boid.x) / $config.target_strength
 #   boid.cy += ($config.target_y - boid.y) / $config.target_strength
 #   #find closest fish
 # end

  #FF::Cmp::Boids.each do |boid|
  #  boid.cx += ($config.target_x - boid.x) / $config.target_strength
  #  boid.cy += ($config.target_y - boid.y) / $config.target_strength
  #end
end
