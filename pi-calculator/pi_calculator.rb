class PiCalculator
  
  def calculate
    square_area = 1
    
    points_in_circle = 0
    num_points = 100000
    origin = {:x => 0.5, :y => 0.5}
    
    num_points.times do
      
      point = {:x => rand, :y => rand}
      
      distance = Math.sqrt((point[:x] - origin[:x])**2 + (point[:y] - origin[:y])**2)
      
      if distance < 0.5
        points_in_circle += 1
      end
          
    end

    circle_area = points_in_circle.to_f / num_points
    pi = 4 * (circle_area / square_area)
    
  end

end