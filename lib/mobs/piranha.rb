class Piranha
  def self.create(x, y)
    puts 'creating...'
    FF::Ent.new(
      FF::Cmp::Piranha[0],
      FF::Cmp::Boids.new(x: x, y: y),
      FF::Cmp::BoidVisuals.new(
        obj: Camera::Image.new(
          'assets/Predator 1.png',
          width: 45, height: 46
        ),
        vect: Camera::Line.new(
          width: 7,
          color: [1.0,0,0,0.5],
          z: -1
        )
      )
    )
  end
end
