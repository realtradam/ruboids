FF::Scn::Default.add(FelFlame::Systems.new('Render', priority: 99) do
  FelFlame::Components::Boids.each do |boid|
    renderable = boid.entities[0].components[FF::Cmp::BoidVisuals][0]
    if boid.flipped
      pad = -renderable.obj.width
    else
      pad = 0
    end
    renderable.vect.x1 = renderable.obj.x = boid.x + renderable.obj.width + (pad*3)
    renderable.vect.y1 = renderable.obj.y = boid.y + renderable.obj.height
    renderable.vect.x2 = renderable.vect.x1 += renderable.obj.width / 2.0
    renderable.vect.y2 = renderable.vect.y1 += renderable.obj.height / 2.0

    renderable.vect.x2 += (boid.vx * 10.0)
    renderable.vect.y2 += (boid.vy * 10.0)
  end
  Camera._redraw
end)
