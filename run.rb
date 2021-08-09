require 'ruby2d'
require 'ruby2d/camera'
require 'felflame'
# If Camera should follow center mass
$follow = false

# Values that can tune strength of certain rules
# Lower is stronger
$cohesion = 3000.0
$seperation = 75.0
$seperation_distance = 125.0
$alignment = 1000.0
$target_strength = 2500.0

# The velocity limit of a boid
# Set to negative to remove limit
$limit = 12.0

# These are changed later by mouse position
$x_target = 0.0
$y_target = 0.0

FF::Cmp.new('SingletonConfig',
            debug: false,
            bounds_strength: 2.0,
            xmax: 480.0, xmin: -580.0,
            ymax: 250.0, ymin: -340.0)
$config = FF::Cmp::SingletonConfig.new

# Used by the Camera Library
set(title: "Ruboids", width: 1164, height: 764, resizable: true)
Dir[File.join(__dir__, 'lib/**', '*.rb')].sort.each { |file| require file }
# Comment out to remove a rule
FF::Scn::BoidCalculations.add FF::Sys::Cohesion
FF::Scn::BoidCalculations.add FF::Sys::Alignment
FF::Scn::BoidCalculations.add FF::Sys::Seperation
FF::Scn::BoidCalculations.add FF::Sys::Target
FF::Scn::BoidCalculations.add FF::Sys::Bounds

FF::Stg.add FF::Scn::BoidCalculations

class GameWindow < Ruby2D::Window
  def initialize
    super
    Camera::Image.new('assets/Background.png', x: -get(:width)+57, y: -get(:height)+97, z: -99)
    randspot = ((-get(:height) / 2)..(get(:height)/2)).to_a
    6.times do
      FF::Ent.new(
        FF::Cmp::Boids.new(x: randspot.sample.to_f, y: randspot.sample.to_f),
        FF::Cmp::BoidVisuals.new(
          obj: Camera::Image.new(
            'assets/Guppy Large Normal.png',
            width: 45, height: 46
            #obj: Camera::Circle.new(
            #  color: [0.86,0.57,0.96,1],
            #  radius: 7,
            #  sectors: 10
          ),
          vect: Camera::Line.new(
            width: 7,
            color: [1.0,0,0,0.5],
            z: -1
          )
        )
      )
    end
    unless $config.debug
      FF::Cmp::BoidVisuals.each do |boid|
        boid.vect.remove
      end
    end
  end

  def update
    $x_target = Camera.coordinate_to_worldspace(get(:mouse_x), get(:mouse_y))[0]
    $y_target = Camera.coordinate_to_worldspace(get(:mouse_y), get(:mouse_y))[1]
    FF::Stage.call 
    Camera.y += 1 if key_held('s')
    Camera.y -= 1 if key_held('w')
    Camera.x += 1 if key_held('d')
    Camera.x -= 1 if key_held('a')
    Camera.zoom *= 1.1 if key_held('z')
    Camera.zoom /= 1.1 if key_held('x')
    if key_held('space')
      FF::Scn::BoidCalculations.call 
    end
  end

  def render
  end
end


gamewindow = GameWindow.new
gamewindow.set(title: get(:title), width: get(:width), height: get(:height), resizable: get(:resizable))
gamewindow.show
