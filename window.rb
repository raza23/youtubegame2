require 'gosu'

class YoutubeGame2 < Gosu::Window
    def initialize
        #  * Sets up game window dimensions and the Screen Title
        super 1600,1130
        self.caption ='Pokemon'
        @background_image = Gosu::Image.new("images/kanto1.png")
        @player = Player.new
        @player.warp(800,575)
    end

    # * Puts all game logic in update method
    def update
        if Gosu.button_down? Gosu::KB_LEFT or Gosu::button_down? Gosu::GP_LEFT
            @player.turn_left
        end

        if Gosu.button_down? Gosu::KB_RIGHT or Gosu::button_down? Gosu::GP_RIGHT
            @player.turn_right
        end

        if Gosu.button_down? Gosu::KB_UP or Gosu::button_down? Gosu::GP_BUTTON_0
            @player.accelerate
        end

        @player.move

    end

    def draw
        @player.draw
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
        @vel_x += Gosu.offset_x(@angle,0.5)
        @vel_y += Gosu.offset_y(@angle,0.5)
    end

    def move
        @x += @vel_x
        @y += @vel_y
        @x %= 640
        @y %= 480

        @vel_x *= 0.95
        @vel_y *= 0.95
    end


    def draw
        @image.draw_rot(@x,@y,1,@angle)
    end
end



YoutubeGame2.new.show