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

	def compare(other_body)
		if x_coordinate > other_body.x_coordinate
			dx = x_coordinate - other_body.x_coordinate
		else
			dx = other_body.x_coordinate - x_coordinate
		end
		return dx # pretty sure this works

		if y_coordinate > other_body.y_coordinate
			dy = y_coordinate - other_body.y_coordinate
		else 
			dy = other_body.y_coordinate - y_coordinate
		end
		return dy # initiallly returns zeroes bc they're all in a line

		distance = sqrt((dx * dx) + (dy * dy))
		return distance # probably works
	end

	# def find_dx(other_body)

	# end

	# def find_dy(other_body)

	# end

	# def distance(other_body)
		
	# end
	# def calculate_force(mass1, mass2)
	# 	force = (G * mass1 * mass2) / (distance * distance)
	# 	return force
	# end

	
end
