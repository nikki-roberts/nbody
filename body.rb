require "gosu"
require_relative "z_order"
require "mathn"



class Body

	G = 6.67408e-11
	TIME = 25000

	attr_accessor :x_coordinate, :y_coordinate, :x_vel, :y_vel, :mass, :image, :radius_of_universe, :radius, :z_velocity

	def initialize(x_coordinate, y_coordinate, x_vel, y_vel, mass, image, radius_of_universe, radius, z_velocity)
		@x_coordinate = x_coordinate
		@y_coordinate = y_coordinate
		@z_coordinate = 0
		@x_vel = x_vel
		@y_vel = y_vel
		@z_velocity = z_velocity
		@radius = radius
		@mass = mass
		@image = image
		@radius_of_universe = radius_of_universe
		file = "images/" + @image
		@image = Gosu::Image.new(file)
		@total_fx = 0
		@total_fy = 0
		@total_fz = 0
		@acc_x = 0
		@acc_y = 0
		@v_x = 0
		@v_y = 0
	end

	def draw()
		@image.draw(((@x_coordinate/radius_of_universe) * 320) + 320, (-(@y_coordinate/radius_of_universe) * 320) + 320, 1)
		# z_coordinate ?? 
	end

	def to_s()

	end

	def calculate_totals(other_body)
		dx = other_body.x_coordinate - x_coordinate

		dy = other_body.y_coordinate - y_coordinate

		distance = Math.sqrt((dx * dx) + (dy * dy))

		force = (G * mass * other_body.mass) / (distance * distance)

		fx = force * (dx / distance)
		@total_fx += fx

		fy = force * (dy / distance)
		@total_fy += fy
	end

	def calculate_z_totals(other_body)
		fz = force * (dz / distance)
		@total_fz += fz
	end

	def calc_acc(body)
		@acc_x = @total_fx / mass
		@acc_y = @total_fy / mass
	end

	def calc_z_acc(body)
		@acc_z = @total_fz / mass
	end

	def calc_z_vel(body)
		@v_z = @z_velocity +(@acc_z * TIME)
	end

	def calc_vel(body)
		@v_x = @x_vel + (@acc_x * TIME)
		@v_y = @y_vel + (@acc_y * TIME)
	end

	def newpos(body)
		pos_x = @x_coordinate + (@v_x * TIME)
		@x_coordinate = pos_x
		pos_y = @y_coordinate + (@v_y * TIME)	
		@y_coordinate = pos_y
		@x_vel = @v_x
		@y_vel = @v_y
	end

	def new_zpos(body)
		pos_z = @z_coordinate + (@v_z * TIME)
		@z_coordinate = pos_z
		if pos_z > 0
			radius = radius * 5
		elsif pos_z < 0
			radius = radius * 0.2
		end
	end

	def reset()
    	@total_fx = 0
    	@total_fy = 0
  	end

  	def reset_z()
  		@total_fz = 0
  	end
	
	def collision(other_body)
		new_radius = radius / 2
		other_new_radius = other_body.radius / 2
		# duplicate the bodies ??
		radius = new_radius
		other_body.radius = other_new_radius
	end

end
