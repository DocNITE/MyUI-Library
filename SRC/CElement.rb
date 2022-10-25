#==============================================================================
# ** Mouse detector element
# **
# ** Author: DocNight
#------------------------------------------------------------------------------
#  This file contain class object                        
#==============================================================================

class CElement < CView
    #--------------------------------------------------
    # * Public attributes
    #--------------------------------------------------
    #--------------------------------------------------
    # * Private attributes
    #--------------------------------------------------
    attr_reader   :prevMbId;
    #--------------------------------------------------
    # * Constructor
    #--------------------------------------------------
    def initialize(_size, _z = System_Settings::MAP_HUD_Z)
        super(_z)
        # Texture
        @size = _size;
        MouseDetector.add(self);
    end
    #--------------------------------------------------
    # * Deconstructor
    #--------------------------------------------------
    def dispose
        MouseDetector.remove(self);
        self.dispose
    end
    #--------------------------------------------------
    # * Update
    #--------------------------------------------------
    def update(mb_state)
        @prevMbId = mb_state;
    end
end