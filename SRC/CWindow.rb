#==============================================================================
# ** Objects container and small managment
# **
# ** Author: DocNight
#------------------------------------------------------------------------------
#  This file contain class object                        
#==============================================================================

module Math

    def self.clamp(_value, _min=0, _max=65536)
        return [[_min, _value].max], _max].min
    end

    def self.map(x, in_min, in_max, out_min, out_max)
        return (x - in_min) * (out_max - out_min) / (in_max - in_min) + out_min;
    end

end

module ViewSDK

    DEFAULT_WINDOW_Z = 1125

    def self.makeWindowBitmap(obj)
        winBitmap = Cache.normal_bitmap("Graphics/System/Window");
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
                obj.bitmap.blt(cursorPos.x, cursorPos.x, winBitmap, Rect.new(64, 0, 16, 16))
                cursorPos.x = 0;
                cursorPos.y = obj.height-16;
            when 2
                obj.bitmap.blt(cursorPos.x, cursorPos.x, winBitmap, Rect.new(64, 64 - 16, 16, 16))
                cursorPos.x = obj.width-16;
                cursorPos.y = obj.height-16;
            when 3
                obj.bitmap.blt(cursorPos.x, cursorPos.x, winBitmap, Rect.new(128 - 16, 64 - 16, 16, 16))
                cursorPos.x = obj.width-16;
                cursorPos.y = 0;
            when 4
                obj.bitmap.blt(cursorPos.x, cursorPos.x, winBitmap, Rect.new(128 - 16, 0, 16, 16))
                cursorPos.x = 0;
                cursorPos.y = 16;
            when 5
                #№obj.bitmap.blt(cursorPos.x, cursorPos.x, winBitmap, Rect.new(128 - 16, 0, 16, 16))
                #№cursorPos.x = 0;
                ##cursorPos.y = 16;
            when 6
            when 7
            when 8

                isdone = true;
            end

            currSide += 1;
        end
    end

end

class CWindow < CElement
    #--------------------------------------------------
    # * Public attributes
    #--------------------------------------------------
    attr_accessor :moveable;
    #--------------------------------------------------
    # * Private attributes
    #--------------------------------------------------
    attr_reader :close;
    attr_reader :title;
    attr_reader :background;
    #--------------------------------------------------
    # * Constructor
    #--------------------------------------------------
    def initialize(_size, _title="", _close=false, _moveable = true, _z = ViewSDK::DEFAULT_WINDOW_Z)
        super(_size, _z)

        @moveable = _moveable;

        newFont = Font.new()
        newFont.name = System_Settings::MESSAGE_WINDOW_FONT_NAME
        newFont.bold = false
        newFont.size = 14
        newFont.outline = false
        newFont.color = Color.new(255, 255, 255, 255);

        # Private
        @pX = 0;
        @pY = 0;
        @canRender = false;

        #@sprite.bitmap = Cache.normal_bitmap("Graphics/System/Window") 
        #@sprite.bitmap = Cache.normal_bitmap("#{MYUI_FOLDER}SRC/EX/window");
        @sprite.bitmap = Bitmap.new(_size.x, _size.y);
        
        #Build win tex

        @close = CButton.new(CVector2.new(20, 20), false, false, false, _z + 1);

        newFont2 = Font.new()
        newFont2.name = System_Settings::MESSAGE_WINDOW_FONT_NAME
        newFont2.bold = false
        newFont2.size = 20
        newFont2.outline = false
        newFont2.color = Color.new(255, 255, 255, 255);

        closeText = CDraw.new(CVector2.new(20, 20), "X", _z + 2);
        closeText.alligment = 1;
        closeText.setPosition(0, 0);
        closeText.font = newFont2;
        closeText.text = "X"
        @close.addChild(closeText);
        @close.setPosition(160, 0)
        addChild(@close);

        if _close == false
            @close.visible = false
        end

        @title = CDraw.new(CVector2.new(180, 14), "", _z + 1);
        @title.setPosition(2, 2);
        @title.font = newFont;
        @title.text = _title
        addChild(@title);

        EventSDK.addEvent("onMouseRealese", method(:OnClose))
        EventSDK.addEvent("onMousePressed", method(:OnPressedMovement))
        EventSDK.addEvent("onMouseRealese", method(:OnRealeseMovement))
        EventSDK.addEvent("onRender",       method(:OnRender))

        @prevMbId   = -1;
    end
    #--------------------------------------------------
    # * Deconstructor
    #--------------------------------------------------
    def dispose
        self.dispose
    end
    #--------------------------------------------------
    # * CWindow element events
    #--------------------------------------------------
    def OnWinClose(arg)
        if arg[1] == @close
            #msgbox "ts"
            self.visible = false;
        end
    end

    def OnWinPressedMovement(arg)
        if arg[1] == self
            @canRender = true
            @pX = Mouse.pos?[MX] - @sprite.x;
            @pY = Mouse.pos?[MY] - @sprite.y;
        end
    end

    def OnWinRealeseMovement(arg)
        if arg[1] == self
            @canRender = false
        end
    end

    def OnWinRender(arg)
        if @canRender == true && @moveable == true
            mResX = Mouse.pos?[MX]-@pY;
            mResY = Mouse.pos?[MY]-@pY;
            if @parent == NULL || @parent == nil
                mResX = Math.clamp(mResX, 0, Graphics.width-@size.x);
                mResY = Math.clamp(mResY, 0, Graphics.height-@size.y);
            else
                mResX = Mouse.pos?[MX]-@sprite.x-@pY;
                mResY = Mouse.pos?[MY]-@sprite.y-@pY;
                mResX = Math.clamp(mResX, 0, @parent.size.x-@size.x);
                mResY = Math.clamp(mResY, 0, @parent.size.y-@size.y);
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

#$GlovalWinTest = CWindow.new(CVector2.new(200,120), "fuck yea", true, true);
#Все работает заебись. Надо только пофиксить CView с его позишен
