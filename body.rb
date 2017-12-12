require "gosu"
require_relative "z_order"
require "mathn"

G = 6.67408e-11
time = 25000
class Body

	attr_accessor :x_coordinate, :y_coordinate, :x_vel, :y_vel, :mass, :image, :radius_of_universe

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
		@total_fx = 0
		@total_fy = 0
	end

	def draw()
		@image.draw(((@x_coordinate/radius_of_universe) * 320) + 320, ((@y_coordinate/radius_of_universe) * 320) + 320, 1)
	end

	def to_s()

	end

	def calculate_totals(other_body)
		dx = x_coordinate - other_body.x_coordinate
		# return dx # pretty sure this works
		dy = y_coordinate - other_body.y_coordinate
		# return dy # initiallly returns zeroes bc they're all in a line

		distance = Math.sqrt((dx * dx) + (dy * dy))
		# return distance # probably works

		force = (G * mass * other_body.mass) / (distance * distance)
		# return force

		fx = force * (dx / distance)
		@total_fx += fx
		# return total_fx # pretty sure this works

		fy = force * (dy / distance)
		@total_fy += fy
		# return total_fy # this works before planets start moving
	end

	def calc_acc(body)
		acc_x = @total_fx / mass
		return acc_x # yaaaa
		acc_y = @total_fy / mass
		return acc_y
	end

	# def calc_vel(body)
	# 	v_x = x_vel + (acc_x * time)
	# 	v_y = y_vel + (acc_y * time)
	# end

	# def find_newpos()
	# 	d = initial_pos + (v * time)
	# end

	def reset()
    	@total_fx = 0
    	@total_fy = 0
  	end

	
end
