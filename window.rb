require 'gosu'

class YoutubeGame2 < Gosu::Window
    def initialize
        #  * Sets up game window dimensions and the Screen Title
        super 1600,1130
        self.caption ='Pokemon'
        @background_image = Gosu::Image.new("images/kanto1.png")
    end

    # * Puts all game logic in update method
    def update

    end

    def draw
        @background_image.draw(0,0,0)
    end
end

class Player
    def initialize
        @image = Gosu::Image.new('images/pokemon_player.png')
        @x = @y = @vel_x = @vel_y = @angle = 0.0 
        @score = 0
    end

    def warp(x,y)
        @x,@y = x,y
    end

    def turn_left
        @angle -= 4.5
    end

    def turn_right
        @angle += 4.5
    end

    def accelerate 
        @vel_x +=Gose.offset_x(@angle,0.5)
        @vel_y +=Gose.offset_y(@angle,0.5)
    end

    def move
    end


    def draw
    end
end



YoutubeGame2.new.show