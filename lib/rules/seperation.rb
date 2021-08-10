# frozen_string_literal: true

FF::Sys.new('Seperation', priority: 50) do
  FF::Cmp::Fish[0].entities.each do |ent|
    boid_update = ent.components[FF::Cmp::Boids].first
    newvec = [0.0, 0.0]
    FF::Cmp::Boids.each do |boid_check|
      next if boid_check == boid_update

      if Math.sqrt(((-boid_check.x + boid_update.x)**2) + ((-boid_check.y + boid_update.y)**2)).abs < $config.seperation_distance
        newvec[0] -= boid_check.x - boid_update.x
        newvec[1] -= boid_check.y - boid_update.y
      end
    end
    boid_update.cx += newvec[0] / $config.seperation
    boid_update.cy += newvec[1] / $config.seperation
  end
  FF::Cmp::Piranha[0].entities.each do |ent|
    boid_update = ent.components[FF::Cmp::Boids].first
    newvec = [0.0, 0.0]
    FF::Cmp::Piranha[0].entities.each do |ent2|
      boid_check = ent2.components[FF::Cmp::Boids].first
      next if boid_check == boid_update

      if Math.sqrt(((-boid_check.x + boid_update.x)**2) + ((-boid_check.y + boid_update.y)**2)).abs < $config.seperation_distance
        newvec[0] -= boid_check.x - boid_update.x
        newvec[1] -= boid_check.y - boid_update.y
      end
    end
    boid_update.cx += newvec[0] / ($config.seperation / 10)
    boid_update.cy += newvec[1] / ($config.seperation / 10)
  end
end

# FF::Sys.new('Seperation', priority: 50) do
#   FF::Cmp::Fish[0].entities.each do |ent_update|
#     boid_update = ent_update.components[FF::Cmp::Boids].first
#     newvec = [0.0,0.0]
#     FF::Cmp::Fish[0].entities.each do |ent_check|
#       boid_check = ent_update.components[FF::Cmp::Boids].first
#       next if boid_check == boid_update
#       if Math.sqrt(((-boid_check.x + boid_update.x)**2) + ((-boid_check.y + boid_update.y)**2)).abs < $config.seperation_distance
#         newvec[0] -= boid_check.x - boid_update.x
#         newvec[1] -= boid_check.y - boid_update.y
#       end
#     end
#     boid_update.cx += newvec[0] / $config.seperation
#     boid_update.cy += newvec[1] / $config.seperation
#   end
# end
