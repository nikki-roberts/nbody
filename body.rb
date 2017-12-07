require "gosu"
require_relative "z_order"
require "mathn"

G = 6.67408e-11

class Body

	attr_reader :x_coordinate, :y_coordinate, :x_vel, :y_vel, :mass, :image, :radius_of_universe 

	def initialize(x_coordinate, y_coordinate, x_vel, y_vel, mass, image, radius_of_universe)
		@x_coordinate = x_coordinate
		@y_coordinate = y_coordinate
		@x_vel = x_vel
		@y_vel = y_vel
		@mass = mass
		@image = image
		@radius_of_universe = radius_of_universe
		file = "images/" + image
		@image = Gosu::Image.new(file)
	end

	def draw()
		@image.draw(((@x_coordinate/radius_of_universe) * 320) + 320, ((@y_coordinate/radius_of_universe) * 320) + 320, 1)
	end

	def to_s()

	end

	def compare_bodies()

	end

	# def calculate_dx(x1, x2)
	# 	dx = 
	# 	return dx
	# end

	# def calculate_dy(y1, y2)
	# 	dy =
	# 	return dy
	# end

	# def calculate_distance(dx, dy)
	# 	distance = sqrt((dx * dx) + (dy * dy))
	# 	return distance
	# end

	# def calculate_force(mass1, mass2)
	# 	force = (G * mass1 * mass2) / (distance * distance)
	# 	return force
	# end

	
end
