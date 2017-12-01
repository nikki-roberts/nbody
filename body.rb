require "gosu"
require_relative "z_order"

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

	def calculate_force(mass1, mass2, )

	end

end
