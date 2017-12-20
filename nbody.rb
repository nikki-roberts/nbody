require "gosu"
require_relative "z_order"
require "./body"

class NbodySimulation < Gosu::Window

  def initialize(file)
    super(640, 640, false)
    self.caption = "NBody simulation"
    @background_image = Gosu::Image.new("images/space.jpg", tileable: true)
    simulation = open(file) 
    info = simulation.read
    @radius_of_universe = 0
    line_num = 1
    @bodies = []
    @number_of_bodies = 0
    @body_count = 0
    done = false
    File.open(file).each do |line| # opening the file in the nbody class, so as to only open once
    # not opening every time a body is created
      
      info = line.split(" ")
      if done == false
        if line_num == 1 && info[0] != nil # skipping the first two lines before the planets
          @number_of_bodies = info[0].to_f
          line_num += 1
        elsif line_num == 2 && info[0] != nil
          @radius_of_universe = info[0].to_f
          line_num += 1
        elsif line_num != 1 && line_num != 2  && info[0] != nil 
         line_num += 1
         @body_count += 1
          if info[7] != nil
            newBody = Body.new(info[0].to_f, info[1].to_f, info[2].to_f, info[3].to_f, info[4].to_f, info[5], @radius_of_universe, info[6].to_f, info[7].to_f)
            @bodies.push(newBody)
          else
            newBody = Body.new(info[0].to_f, info[1].to_f, info[2].to_f, info[3].to_f, info[4].to_f, info[5], @radius_of_universe, info[6].to_f)
            @bodies.push(newBody)
          end
          if @body_count >= @number_of_bodies
            done = true
          end 
        end
      end
    end
  end

  def update
    @bodies.each do |body|
      body.reset()
      if body.info[7] != nil ??
        body.reset_z()
      end
    end
    @bodies.each do |body|
      @bodies.each do |other_body| 
        if body != other_body
          body.calculate_totals(other_body)
        end
        if body.info[7] != nil
          body.calculate_z_totals(other_body)
        end
      end
    end
    @bodies.each do |body|
      body.calc_acc(body)
      body.calc_vel(body)
      body.newpos(body)
      if body.info[7] != nil
        body.calc_z_acc(body)
        body.calc_z_vel(body)
        body.new_zpos(body)
      end
    end

  end

  def draw
    @background_image.draw(0, 0, ZOrder::Background)
    @bodies.each do |body|
      body.draw()
    end
  end

  def button_down(id)
    close if id == Gosu::KbEscape
  end

 
end

file = "simulations/"

if ARGV.length == 0
  # default simulation, show planets
  file = file + "planets.txt"
else
  input = ARGV
  input = input[0]
  file = file + input
  # puts file
end 

window = NbodySimulation.new(file)
window.show


