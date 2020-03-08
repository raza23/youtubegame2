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


YoutubeGame2.new.show