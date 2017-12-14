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
    radius_of_universe = 0
    line_num = 0
    @bodies = []
    File.open(file).each do |line| # opening the file in the nbody class, so as to only open once
    # not opening every time a body is created
      line_num += 1
      info = line.split(" ")
      if line_num == 1  # skipping the first two lines before the planets
        number_of_bodies = info
      elsif line_num == 2 
        radius_of_universe = info[0].to_f
      elsif line_num != 1 && line_num != 2
        
        newBody = Body.new(info[0].to_f, info[1].to_f, info[2].to_f, info[3].to_f, info[4].to_f, info[5].to_s, radius_of_universe)
        @bodies.push(newBody)
      end
    end
  end

  def update
    @bodies.each do |body|
      body.reset()
    end
    @bodies.each do |body|
      @bodies.each do |other_body| 
        if body != other_body
          body.calculate_totals(other_body)
        end
      end
    end
    @bodies.each do |body|
      body.calc_acc(body)
      body.calc_vel(body)
      body.newpos(body)
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


