#==============================================================================
# ** Texture object class
# **
# ** Author: DocNight
#------------------------------------------------------------------------------
#  This file contain class object                        
#==============================================================================

# Global SDK
module ViewSDK

    module PathMode
        CONSTANT = 0;
        CUSTOM   = 1;
    end

    TEXTURE_PATH        = "Graphics/System/";
    TEXTURE_PATH_MODE   = PathMode::CONSTANT;

end

#2d pos class
class CTexture < CView
    #--------------------------------------------------
    # * Public attributes
    #--------------------------------------------------
    #--------------------------------------------------
    # * Private attributes
    #--------------------------------------------------
    #--------------------------------------------------
    # * Constructor
    #--------------------------------------------------
    def initialize(_rectangle=-1, _texture=-1, _z = System_Settings::MAP_HUD_Z)
        super(_z)

        texPath = -1;
        if ViewSDK::TEXTURE_PATH_MODE == 1
            texPath = _texture;
        else
            texPath = ViewSDK::TEXTURE_PATH + _texture;
        end

        # Define texture
        @sprite.bitmap      = Cache.normal_bitmap(texPath) if _texture != -1
        @sprite.src_rect    = _rectangle if _rectangle != -1
        @size               = CVector2.new(_rectangle.width, _rectangle.height);
    end
    #--------------------------------------------------
    # * Deconstructor
    #--------------------------------------------------
    def dispose
        self.dispose
    end
    #--------------------------------------------------
    # * Set Rectangle
    #    _rect : class Rect
    #--------------------------------------------------
    def setRect(_rect)
        @sprite.src_rect = _rect;
    end
    #--------------------------------------------------
    # * Set Texture
    #    _rect : type String
    #--------------------------------------------------
    def setTexture(_tex)
        @sprite.bitmap = Cache.normal_bitmap(ViewSDK::TEXTURE_PATH + _tex)
    end
end