require 'ruby2d'
require 'ruby2d/camera'
require 'felflame'

# configuration for the simulation
# change values here to see a change in the simulation
FF::Cmp.new('SingletonConfig',
            # Show vectors
            debug: false,

            # If the camera should follow the "center mass"
            follow: false,

            # The velocity limit of a boid
            # Set to negative to disable
            limit: 6.0,

            # How strong the bounds should be
            # Higher is stronger
            bounds_strength: 1.0,
            # What the bounds are
            xmax: 450.0, xmin: -580.0,
            ymax: 250.0, ymin: -340.0,

            # How much the boids try to pull together
            # Smaller is stronger
            cohesion: 6000.0,

            # How much the boids push away from eachother
            # Smaller is stronger
            seperation: 60.0, 
            # What the range of seperating should be
            seperation_distance: 50.0,

            # How strong their vector alignment should be
            # Smaller is stronger
            alignment: 1000.0,

            # How much they try to follow their target
            # Larger is strongzer
            target_strength: 500.0,

            # These are later set by the mouse position
            target_x: 0, target_y: 0)
$config = FF::Cmp::SingletonConfig.new

# Used by the Camera Library
set(title: "Ruboids", width: 1164, height: 764, resizable: true)


Dir[File.join(__dir__, 'lib/**', '*.rb')].sort.each { |file| require file }

# Comment out to remove a rule
FF::Scn::BoidCalculations.add FF::Sys::Cohesion
#FF::Scn::BoidCalculations.add FF::Sys::Alignment
FF::Scn::BoidCalculations.add FF::Sys::Seperation
FF::Scn::BoidCalculations.add FF::Sys::Target
FF::Scn::BoidCalculations.add FF::Sys::Bounds

FF::Stg.add FF::Scn::BoidCalculations

class GameWindow < Ruby2D::Window
  def initialize
    super
    Camera::Image.new('assets/Background.png', x: -get(:width)+57, y: -get(:height)+97, z: -99)
    randspot = ((-get(:height) / 2)..(get(:height)/2)).to_a
    50.times do
      Fish.create(randspot.sample.to_f, randspot.sample.to_f)
    end
    #2.times do
    #  Piranha.create(randspot.sample.to_f, randspot.sample.to_f)
    #end
    unless $config.debug
      FF::Cmp::BoidVisuals.each do |boid|
        boid.vect.remove
      end
    end
  end

  def update
    $config.target_x = Camera.coordinate_to_worldspace(get(:mouse_x), get(:mouse_y))[0]
    $config.target_y = Camera.coordinate_to_worldspace(get(:mouse_y), get(:mouse_y))[1]
    if key_down('space')
      Piranha.create($config.target_x, $config.target_y)
    end
    FF::Stage.call 
    Camera.y += 1 if key_held('s')
    Camera.y -= 1 if key_held('w')
    Camera.x += 1 if key_held('d')
    Camera.x -= 1 if key_held('a')
    Camera.zoom *= 1.1 if key_held('z')
    Camera.zoom /= 1.1 if key_held('x')
  end

  def render
    puts get(:fps)
  end
end


gamewindow = GameWindow.new
gamewindow.set(title: get(:title), width: get(:width), height: get(:height), resizable: get(:resizable))
gamewindow.show
