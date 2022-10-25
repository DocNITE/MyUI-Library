#==============================================================================
# ** GUI button
# **
# ** Author: DocNight
#------------------------------------------------------------------------------
#  This file contain class object                        
#==============================================================================

class CButton < CElement
    #--------------------------------------------------
    # * Public attributes
    #--------------------------------------------------
    attr_accessor :idleTex;           # When in normal
    attr_accessor :focusTex;          # When focused
    attr_accessor :pressedTex;        # When pressed
    #--------------------------------------------------
    # * Private attributes
    #--------------------------------------------------
    #--------------------------------------------------
    # * Constructor
    #--------------------------------------------------
    def initialize(_size, _idle=-1, _focus=-1, _pressed=-1, _z = System_Settings::MAP_HUD_Z)
        super(_size, _z)
        # Texture
        @idleTex    = _idle
        @focusTex   = _focus
        @pressedTex = _pressed

        @sprite.bitmap = Cache.normal_bitmap(@idleTex)

        @prevMbId   = -1;
    end
    #--------------------------------------------------
    # * Deconstructor
    #--------------------------------------------------
    def dispose
        self.dispose
    end
    #--------------------------------------------------
    # * Update
    #    MB_IDLE    = 0;
    #    MB_FOCUSED = 1;
    #    MB_PRESSED = 2;
    #--------------------------------------------------
    def update(mb_state)

        if @prevMbId[1] != mb_state[1]
            case mb_state[1]

            when MouseDetector::MB_IDLE
                @sprite.bitmap = Cache.normal_bitmap(@idleTex)
            when MouseDetector::MB_FOCUSED
                @sprite.bitmap = Cache.normal_bitmap(@focusTex)
            when MouseDetector::MB_PRESSED
                @sprite.bitmap = Cache.normal_bitmap(@pressedTex)
            else

            end
        end

        @prevMbId = mb_state;
    end
end
$GlobalButtonNotEditPls = CElement.new(CVector2.new(Graphics.width, Graphics.height), 1)

#$NewButton = CButton.new(CVector2.new(212, 42), "Graphics/System/AchUlk", "Graphics/System/GameOver_bad2", "Graphics/System/arrows", 1125)
#$NewButton.position = CVector2.new(440, 100);

#def mouse_dbdbd_test(arg)  #1 - focused, id button, element
#    msgbox "#{arg[0]}";
#end
#EventSDK.addEvent("onMouseRealese", method(:mouse_dbdbd_test));