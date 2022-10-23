#==============================================================================
# ** Text object class
# **
# ** Author: DocNight
#------------------------------------------------------------------------------
#  This file contain class object                        
#==============================================================================

# Global SDK
module ViewSDK

    #BLT_LIST        = Array.new(MAX_BLT_ELEMETS);
    EMPTY_BITMAP    = Bitmap.new(Graphics.width, Graphics.height);

end

#Main class
class CDraw < CView
    #--------------------------------------------------
    # * Public attributes
    #--------------------------------------------------
    attr_accessor :text                 # Text info
    attr_accessor :font                 # Font info
    attr_accessor :alligment            # 
    #--------------------------------------------------
    # * Private attributes
    #--------------------------------------------------
    attr_reader   :autoBlt              # Auto update
    #--------------------------------------------------
    # * Constructor
    #--------------------------------------------------
    def initialize(_size=-1, _text="", _z = System_Settings::MAP_HUD_Z)
        super(_z)
        # Auto update sprite
        @autoBlt    = true;
        #for i in 0..MAX_BLT_ELEMETS-1 do
        #    if ViewSDK::BLT_LIST[i] == nil
        #        ViewSDK::BLT_LIST[i] = self;
        #    end
        #end
        # Define text
        @text          = _text;
        @font          = Font.new();
        @alligment     = 0;

        @sprite.bitmap      = ViewSDK::EMPTY_BITMAP;
        @size               = _size;
        blit
    end
    #--------------------------------------------------
    # * Deconstructor
    #--------------------------------------------------
    def dispose
        #for i in 0..MAX_BLT_ELEMETS-1 do
        #    if ViewSDK::BLT_LIST[i] == self
        #        ViewSDK::BLT_LIST[i] = nil;
        #    end
        #end
        self.dispose
    end
    #--------------------------------------------------
    # * Update Text
    #--------------------------------------------------
    def blit
        if !@autoBlt
            return 
        end
    
        tBmp = @sprite.bitmap;
        # clear previous text
        tBmp.clear
        # redraw
        if tBmp.font != @font
            tBmp.font = font;
        end
		tBmp.draw_text(@position.x, @position.y, @size.x, @size.y, @text, alligment)
    end
    #--------------------------------------------------
    # * Set Text
    #    _text : type String
    #--------------------------------------------------
    def setText(_text)
        self.text = _text;
    end
    #--------------------------------------------------
    # * Set Aligment
    #    _val : type Int
    #--------------------------------------------------
    def setAlligment(_val)
        self.alligment = _val;
    end
    #--------------------------------------------------
    # * ...
    #--------------------------------------------------
    def text=(_text)
        @text = _text;
        blit
    end
    def position=(_coord)
        @position = _coord;
        blit
    end
end