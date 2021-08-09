class Fish
  def self.create(x, y)
    puts 'creating...'
    FF::Ent.new(
      FF::Cmp::Fish[0],
      FF::Cmp::Boids.new(x: x, y: y),
      FF::Cmp::BoidVisuals.new(
        obj: Camera::Image.new(
          'assets/Guppy Large Normal.png',
          width: 25, height: 26
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
