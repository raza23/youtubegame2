require 'gosu'

module ZOrder
    BACKGROUND,POKEBALLS,PLAYER,UI = *0..3
end

class YoutubeGame2 < Gosu::Window
    def initialize
        #  * Sets up game window dimensions and the Screen Title
        super 1600,1130
        self.caption ='Pokemon'
        @background_image = Gosu::Image.new("images/kanto1.png")
        @player = Player.new
        @player.warp(400,575)
        @pokeball = Gosu::Image.load_tiles("images/pokeball.png",200,200)
        @pokeballs = Array.new
        @font = Gosu::Font.new(40)
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
        @player.catch(@pokeballs)

        if rand(100) < 4 and @pokeballs.size < 25
            @pokeballs.push(PokeBall.new(@pokeball))
        end

    end

    def draw
        @player.draw
        @background_image.draw(0,0,ZOrder::BACKGROUND)
        @pokeballs.each{|ball| ball.draw}
        @font.draw_text("Score: #{@player.score}", 10, 10, ZOrder::UI, 1.0, 1.0, Gosu::Color::BLACK)

    end
end









class Player

    attr_reader :score
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
        @x %= 1600
        @y %= 1130

        @vel_x *= 0.95
        @vel_y *= 0.95
    end


    def draw
        @image.draw_rot(@x,@y,1,@angle)
    end

    def score 
        @score
    end

    def catch(pokeballs)
        pokeballs.reject! do |ball| 
            if Gosu.distance(@x,@y, ball.x,ball.y) < 35
                @score += 10
                true 
            else
                false
            end
        end
    end

    

end



class PokeBall
    attr_reader :x, :y
    def initialize(animation)
        @animation = animation
        @color = Gosu::Color::BLACK.dup
        @color.red = rand(256-40)+40
        @color.green = rand(256-40)+40
        @color.blue = rand(256-40)+40
        @x = rand * 1600
        @y = rand * 1130

    end

    def draw
        img = @animation[Gosu.milliseconds / 100 % @animation.size]
        img.draw(@x - img.width / 2.0, @y - img.height / 2.0, ZOrder::POKEBALLS,1,1,@color,:add)
    end

end


YoutubeGame2.new.show