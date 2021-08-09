#FF::Scn::Default.add(FelFlame::Systems.new('Render', priority: 99) do
#  Camera._redraw
#end)
FF::Scn::Default.add(FelFlame::Systems.new('Render', priority: 99) do
  FelFlame::Components::Boids.each do |boid|
    renderable = boid.entities[0].components[FF::Cmp::BoidVisuals][0]
    renderable.vect.x2 = renderable.vect.x1 = renderable.obj.x = boid.x + renderable.obj.radius
    renderable.vect.y2 = renderable.vect.y1 = renderable.obj.y = boid.y + renderable.obj.radius
    renderable.vect.x1 += renderable.obj.radius
    renderable.vect.y1 += renderable.obj.radius

    renderable.vect.x2 += (boid.vx * 3) + (renderable.obj.radius * 2)
    renderable.vect.y2 += (boid.vy * 3) + (renderable.obj.radius * 2)
    #Circle.draw(x: boid.x,
    #            y: boid.y,
    #            color: [0.86,0.57,0.96,1],
    #            radius: 7,
    #            sectors: 10)
  end
  Camera._redraw
end)
