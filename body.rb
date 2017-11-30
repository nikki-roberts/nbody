require "gosu"
require_relative "z_order"

class Body

	attr_reader :x_coordinate, :y_coordinate, :x_vel, :y_vel, :mass, :image 

	def initialize(x_coordinate, y_coordinate, x_vel, y_vel, mass, image)
		@x_coordinate = x_coordinate
		@y_coordinate = y_coordinate
		@x_vel = x_vel
		@y_vel = y_vel
		@mass = mass
		@image = image
	end

	def draw()

	end
end
