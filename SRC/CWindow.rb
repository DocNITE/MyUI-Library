#==============================================================================
# ** Objects container and small managment
# **
# ** Author: DocNight
#------------------------------------------------------------------------------
#  This file contain class object                        
#==============================================================================

class CWindow < CElement
    #--------------------------------------------------
    # * Public attributes
    #--------------------------------------------------
    #--------------------------------------------------
    # * Private attributes
    #--------------------------------------------------
    attr_reader :backgroundTex;     # Background image
    #--------------------------------------------------
    # * Constructor
    #--------------------------------------------------
    def initialize(_size, _title="", _close=true, _z = System_Settings::MAP_HUD_Z)
        super(_size, _z)

        #@sprite.bitmap = Cache.normal_bitmap("Graphics/System/Window")
        @sprite.bitmap = Bitmap.new(_size.x, _size.y);
        @sprite.bitmap.blt(0, 0, Cache.normal_bitmap("Graphics/System/Window"), Rect.new(0,0, 8, 8))
        @prevMbId   = -1;
    end
    #--------------------------------------------------
    # * Deconstructor
    #--------------------------------------------------
    def dispose
        self.dispose
    end
end


$FuckWindow = CWindow.new(CVector2.new(300, 100), "Window Test", true, 1125)
