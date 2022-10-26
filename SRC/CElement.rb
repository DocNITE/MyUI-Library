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
    # * Mouse check rectangle
    #--------------------------------------------------
    def within(m_x, m_y)
        tmpX = @sprite.x;
        tmpY = @sprite.y;
        tmpW = @size.x;
        tmpH = @size.y;
        return false if m_x < tmpX or m_y < tmpY
		bound_x = tmpX + tmpW; bound_y = tmpY + tmpH
		return true if m_x < bound_x and m_y < bound_y
		return false
    end
    #--------------------------------------------------
    # * Update
    #--------------------------------------------------
    def update(mb_state)
        @prevMbId = mb_state;
    end
end