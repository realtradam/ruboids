FF::Sys.new('Target', priority: 50) do

  FF::Cmp::Piranha[0].entities.each do |ent|
    closest = []
    boid = ent.components[FF::Cmp::Boids].first
    FF::Cmp::Fish[0].entities.each do |_fish|
      fish = _fish.components[FF::Cmp::Boids].first
      unless (fish.x > $config.xmax) || (fish.x < $config.xmin) || (fish.y > $config.ymax) || (fish.y < $config.ymin)
        if closest[0].nil? || Math.sqrt(((boid.x - fish.x)**2) + ((boid.y - fish.y)**2)).abs < closest[0]
          closest[0] = Math.sqrt(((boid.x - fish.x)**2) + ((boid.y - fish.y)**2)).abs
          closest[1] = fish
        end
      end
    end
    unless closest[0].nil?
      boid.cx += ((closest[1].x - boid.x) / $config.target_strength)
      boid.cy += ((closest[1].y - boid.y) / $config.target_strength)
    end
  end

  FF::Cmp::Fish[0].entities.each do |ent|
    closest = []
    boid = ent.components[FF::Cmp::Boids].first
    FF::Cmp::Piranha[0].entities.each do |_piranha|
      piranha = _piranha.components[FF::Cmp::Boids].first
      unless Math.sqrt(((boid.x - piranha.x)**2) + ((boid.y - piranha.y)**2)).abs > $config.target_fear
        #boid.cx -= ($config.target_strength / (piranha.x + boid.x))
        #boid.cy -= ($config.target_strength / (piranha.y + boid.y))
        boid.cx -= ((piranha.x - boid.x) / ($config.target_strength))
        boid.cy -= ((piranha.y - boid.y) / ($config.target_strength))
      end
      #if closest[0].nil? || Math.sqrt(((boid.x - fish.x)**2) + ((boid.y + fish.y)**2)).abs < closest[0]
      #  closest[0] = Math.sqrt(((boid.x - fish.x)**2) + ((boid.y + fish.y)**2)).abs
      #  closest[1] = fish
      #end
    end
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
