require 'ruby2d'
require 'ruby2d/camera'
require 'felflame'
module Ruby2D
  class Window
    def mouse_pry
      @mouse_buttons_down
    end
  end
end
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
            bounds_strength: 10.0,
            # What the bounds are
            xmax: 450.0, xmin: -580.0,
            ymax: 250.0, ymin: -340.0,

            # How much the boids try to pull together
            # Smaller is stronger
            cohesion: 10000.0,

            # How much the boids push away from eachother
            # Smaller is stronger
            seperation: 115.0, 
            # What the range of seperating should be
            seperation_distance: 70.0,

            # Alignment rule disabled
            # How strong their vector alignment should be
            # Smaller is stronger
            alignment: 1000.0,

            # How much they try to follow their target
            # smaller is stronger
            target_strength: 40.0,
            # Radius that fish should avoid the piranha
            target_fear: 150.0,

            # These are later set by the mouse position
            target_x: 0, target_y: 0)
$config = FF::Cmp::SingletonConfig.new

# Used by the Camera Library
set(title: "Ruboids", width: 1164, height: 764, resizable: true)


Dir[File.join(__dir__, 'lib/**', '*.rb')].sort.each { |file| require file }

class GameWindow < Ruby2D::Window
  def initialize
    super
    # Comment out to remove a rule
    FF::Scn::BoidCalculations.add FF::Sys::Cohesion
    #FF::Scn::BoidCalculations.add FF::Sys::Alignment
    FF::Scn::BoidCalculations.add FF::Sys::Seperation
    FF::Scn::BoidCalculations.add FF::Sys::Target
    FF::Scn::BoidCalculations.add FF::Sys::Bounds

    FF::Stg.add FF::Scn::BoidCalculations

    # background
    Camera::Image.new('assets/aquarium.png', x: -get(:width)+57, y: -get(:height)+97, z: -98)

    # stores array of valid positions on which to spawn
    # (not actually valid but close enough)
    randspot = [(($config.xmin.to_i)..($config.xmax.to_i)).to_a, (($config.ymin.to_i)..($config.ymax.to_i)).to_a]

    @mouse_right_held = false
    @x_mouse_previous = get(:mouse_x)
    @y_mouse_previous = get(:mouse_y)

    70.times do
      Fish.create(randspot[0].sample.to_f, randspot[1].sample.to_f)
    end

    unless $config.debug
      FF::Cmp::BoidVisuals.each do |boid|
        boid.vect.remove
      end
    end
  end

  def update
    if mouse_down(:right)
      @mouse_right_held = true
    elsif mouse_up(:right)
      @mouse_right_held = false
    end

    if @mouse_right_held && mouse_move
      Camera.x += Camera.coordinate_to_worldspace(@x_mouse_previous, @y_mouse_previous)[0] - Camera.coordinate_to_worldspace(get(:mouse_x), get(:mouse_y))[0]
      Camera.y += Camera.coordinate_to_worldspace(@x_mouse_previous, @y_mouse_previous)[1] - Camera.coordinate_to_worldspace(get(:mouse_x), get(:mouse_y))[1]
      #Camera.y -= (@mouse_move_delta_y * 5) / Camera.zoom #Camera.coordinate_to_worldspace(@mouse_move_delta_y,0)
    end

    if mouse_scroll
      if @mouse_scroll_delta_y < 0
      Camera.zoom *= 1.1
      elsif @mouse_scroll_delta_y > 0 
      Camera.zoom /= 1.1
      end
    end

    @x_mouse_previous = get(:mouse_x)
    @y_mouse_previous = get(:mouse_y)

    $config.target_x = Camera.coordinate_to_worldspace(get(:mouse_x), get(:mouse_y))[0]
    $config.target_y = Camera.coordinate_to_worldspace(get(:mouse_y), get(:mouse_y))[1]
    if mouse_down(:left)
      a = Piranha.create($config.target_x - 75, $config.target_y - 75)
      a.components[FF::Cmp::BoidVisuals][0].vect.remove unless $config.debug
    end
    FF::Stage.call 
    Camera.y += 5 if key_held('s')
    Camera.y -= 5 if key_held('w')
    Camera.x += 5 if key_held('d')
    Camera.x -= 5 if key_held('a')
    Camera.zoom *= 1.1 if key_held('z')
    Camera.zoom /= 1.1 if key_held('x')
  end

  def render
    #puts get(:fps)
  end
end


gamewindow = GameWindow.new
gamewindow.set(title: get(:title), width: get(:width), height: get(:height), resizable: get(:resizable))
gamewindow.show
