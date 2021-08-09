require 'ruby2d'
require 'ruby2d/camera'
require 'felflame'

Dir[File.join(__dir__, 'lib/**', '*.rb')].sort.each { |file| require file }
#FF::Scn::BoidCalculations.remove FF::Sys::Cohesion
FF::Stg.remove FF::Scn::BoidCalculations

class GameWindow < Ruby2D::Window
  def initialize
    super
    #Camera.x = 10
    #Camera.y = 10
    randspot = ((-720 / 2)..(720/2)).to_a
    @ent = FF::Ent.new(
      FF::Cmp::Boids.new(x: randspot.sample, y:randspot.sample),
      FF::Cmp::BoidVisuals.new(
        obj: Camera::Circle.new(
          color: [0.86,1.0,0.96,1],
          radius: 7,
          sectors: 10
        ),
        vect: Camera::Line.new(
          width: 7,
          color: 'red',
          z: -1
        )
      )
    )
    5.times do
      FF::Ent.new(
        FF::Cmp::Boids.new(x: randspot.sample, y:randspot.sample),
        FF::Cmp::BoidVisuals.new(
          obj: Camera::Circle.new(
            color: [0.86,0.57,0.96,1],
            radius: 7,
            sectors: 10
          ),
          vect: Camera::Line.new(
            width: 7,
            color: 'red',
            z: -1
          )
        )
      )
    end
  end

  def update
    FF::Stage.call 
    Camera.y += 5 if key_held('s')
    Camera.y -= 5 if key_held('w')
    Camera.x += 5 if key_held('d')
    Camera.x -= 5 if key_held('a')
    Camera.zoom *= 1.1 if key_held('z')
    Camera.zoom /= 1.1 if key_held('x')
    if key_held('space')
      FF::Scn::BoidCalculations.call #if key_held('space')
      puts "X: #{@ent.components[FF::Cmp::Boids].first.x}"
      puts "Y: #{@ent.components[FF::Cmp::Boids].first.y}"
      puts "VX:#{@ent.components[FF::Cmp::Boids].first.vx}"
      puts "VY:#{@ent.components[FF::Cmp::Boids].first.vy}"
    end
  end

  def render
  end
end


gamewindow = GameWindow.new
set(title: "Ruboids", width: 1280, height: 720, resizable: true)
gamewindow.set(title: "Ruboids", width: 1280, height: 720, resizable: true)
gamewindow.show
