#==============================================================================
# ** Mouse detector element
# **
# ** Author: DocNight
#------------------------------------------------------------------------------
#  This file contain class object                        
#==============================================================================

module ViewSDK

    DEFAULT_WINDOW_Z = 1125

    FOCUS_COLOR = Color.new(255, 0, 0, 255)
    IDLE_COLOR  = Color.new(255, 255, 255, 255)

    def self.makeInfoBitmap(obj)
        obj.bitmap.clear
        winBitmap = Cache.normal_bitmap("#{MYUI_FOLDER}TEX/Info");
        cursorPos = CVector2.new(0, 0);
        #currColor = -1;
        currSide  = 1;
        isdone    = false;
        #1------8-------4
        #|              |
        #5              7
        #|              |
        #2-------6------3
        while !isdone
            case currSide
            when 1
                obj.bitmap.blt(cursorPos.x, cursorPos.y, winBitmap, Rect.new(0, 0, 4, 4))
                cursorPos.x = 0;
                cursorPos.y = obj.height-4;
            when 2
                obj.bitmap.blt(cursorPos.x, cursorPos.y, winBitmap, Rect.new(0, 32-4, 4, 4))
                cursorPos.x = obj.width-4;
                cursorPos.y = obj.height-4;
            when 3
                obj.bitmap.blt(cursorPos.x, cursorPos.y, winBitmap, Rect.new(32 - 4, 32 - 4, 4, 4))
                cursorPos.x = obj.width-4;
                cursorPos.y = 0;
            when 4
                obj.bitmap.blt(cursorPos.x, cursorPos.y, winBitmap, Rect.new(32 - 4, 0, 4, 4))
                cursorPos.x = 0;
                cursorPos.y = 4;
            when 5
                for y in 0..obj.bitmap.height-9 do
                    obj.bitmap.blt(0, cursorPos.y, winBitmap, Rect.new(0, 4, 4, 1));
                    obj.bitmap.blt(obj.bitmap.width-4, cursorPos.y, winBitmap, Rect.new(32-4, 4, 4, 1));
                    cursorPos.y += 1;
                end
                cursorPos.x = 4;
                cursorPos.y = 0;
            when 6
                for x in 0..obj.bitmap.width-9 do
                    obj.bitmap.blt(cursorPos.x, 0, winBitmap, Rect.new(0+4, 0, 1, 4));
                    obj.bitmap.blt(cursorPos.x, obj.bitmap.height-4, winBitmap, Rect.new(0+4, 32-4, 1, 4));
                    cursorPos.x += 1;
                end
                cursorPos.x = 0;
                cursorPos.y = 0;

                local_col = obj.bitmap.get_pixel(3, 3);
                obj.bitmap.fill_rect(4, 4, obj.bitmap.width-6, obj.bitmap.height-6, local_col)

                isdone = true;
            end

            currSide += 1;
        end
    end

end

class CElement < CView
    #--------------------------------------------------
    # * Public attributes
    #--------------------------------------------------
    attr_accessor :moveable;
    #--------------------------------------------------
    # * Private attributes
    #--------------------------------------------------
    attr_reader   :prevMbId;
    #--------------------------------------------------
    # * Constructor
    #--------------------------------------------------
    def initialize(_size, _movement = false, _z = System_Settings::MAP_HUD_Z)
        super(_z)
        # Texture
        @size = _size;
        @moveable = _movement

        @sprite.bitmap = Bitmap.new(@size.x, @size.y);

        EventSDK.addEvent("onMouseLostFocus",   method(:OnLostMovementFocus))
        EventSDK.addEvent("onMousePressed",     method(:OnPressedMovement))
        EventSDK.addEvent("onMouseRealese",     method(:OnRealeseMovement))
        EventSDK.addEvent("onRender",           method(:OnRenderMovement))

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
    #--------------------------------------------------
    # * Events
    #--------------------------------------------------
    def OnLostMovementFocus(element)
        if element == self
            @canRender = false
        end
    end

    def OnPressedMovement(arg)
        if arg[1] == self
            @canRender = true
            @pX = Mouse.pos?[MX] - @sprite.x;
            @pY = Mouse.pos?[MY] - @sprite.y;
        end
    end

    def OnRealeseMovement(arg)
        if arg[1] == self
            @canRender = false
        end
    end

    def OnRenderMovement(arg)
        if @canRender == true && @moveable == true
            mResX = Mouse.pos?[MX]-@pX;
            mResY = Mouse.pos?[MY]-@pY;
            if @parent == NULL || @parent == nil
                mResX = Math.clamp(mResX, 0, Graphics.width-@size.x);
                mResY = Math.clamp(mResY, 0, Graphics.height-@size.y);
            else
                mResX = Math.clamp(mResX, 0, Graphics.width-@size.x);
                mResY = Math.clamp(mResY, 0, Graphics.height-@size.y);
 
                mResX = Math.clamp((mResX - @parent.sprite.x), 0, @parent.size.x-@size.x)
                mResY = Math.clamp((mResY - @parent.sprite.y), 0, @parent.size.y-@size.y)
            end
            self.position = CVector2.new(mResX, mResY);
        end
    end
    #--------------------------------------------------
    # * ...
    #--------------------------------------------------
    def moveable=(_toggle)
        @moveable = _toggle;
    end
end