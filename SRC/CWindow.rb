#==============================================================================
# ** Objects container and small managment
# **
# ** Author: DocNight
#------------------------------------------------------------------------------
#  This file contain class object                        
#==============================================================================

module Math

    def self.clamp(_value, _min=0, _max=65536)
        return [[_min, _value].max, _max].min
    end

    def self.map(x, in_min, in_max, out_min, out_max)
        return (x - in_min) * (out_max - out_min) / (in_max - in_min) + out_min;
    end

end

module ViewSDK

    DEFAULT_WINDOW_Z = 1125

    FOCUS_COLOR = Color.new(255, 0, 0, 255)
    IDLE_COLOR  = Color.new(255, 255, 255, 255)

    def self.makeWindowBitmap(obj)
        obj.bitmap.clear
        winBitmap = Cache.normal_bitmap("#{MYUI_FOLDER}TEX/Window");
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
                obj.bitmap.blt(cursorPos.x, cursorPos.y, winBitmap, Rect.new(0, 0, 16, 16))
                cursorPos.x = 0;
                cursorPos.y = obj.height-16;
            when 2
                obj.bitmap.blt(cursorPos.x, cursorPos.y, winBitmap, Rect.new(0, 64-16, 16, 16))
                cursorPos.x = obj.width-16;
                cursorPos.y = obj.height-16;
            when 3
                obj.bitmap.blt(cursorPos.x, cursorPos.y, winBitmap, Rect.new(64 - 16, 64 - 16, 16, 16))
                cursorPos.x = obj.width-16;
                cursorPos.y = 0;
            when 4
                obj.bitmap.blt(cursorPos.x, cursorPos.y, winBitmap, Rect.new(64 - 16, 0, 16, 16))
                cursorPos.x = 0;
                cursorPos.y = 16;
            when 5
                for y in 0..obj.bitmap.height-33 do
                    obj.bitmap.blt(0, cursorPos.y, winBitmap, Rect.new(0, 16, 16, 1));
                    obj.bitmap.blt(obj.bitmap.width-16, cursorPos.y, winBitmap, Rect.new(64-16, 16, 16, 1));
                    cursorPos.y += 1;
                end
                cursorPos.x = 16;
                cursorPos.y = 0;
            when 6
                for x in 0..obj.bitmap.width-33 do
                    obj.bitmap.blt(cursorPos.x, 0, winBitmap, Rect.new(0+16, 0, 1, 16));
                    obj.bitmap.blt(cursorPos.x, obj.bitmap.height-16, winBitmap, Rect.new(0+16, 64-16, 1, 16));
                    cursorPos.x += 1;
                end
                cursorPos.x = 0;
                cursorPos.y = 0;

                local_col = obj.bitmap.get_pixel(15, 15);
                obj.bitmap.fill_rect(16, 16, obj.bitmap.width-32, obj.bitmap.height-32, local_col)

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
        super(_size, _moveable, _z)

        #@moveable = _moveable;

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
        ViewSDK.makeWindowBitmap(@sprite);
        
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
        #closeText.sprite.bitmap.fill_rect(0, 0, 20, 20, ViewSDK::FOCUS_COLOR) # for test
        @close.addChild(closeText);
        @close.setPosition(_size.x-20, 0)
        addChild(@close);

        if _close == false
            @close.visible = false
        end

        @title = CDraw.new(CVector2.new(180, 14), "", _z + 1);
        @title.setPosition(4, 4);
        @title.font = newFont;
        @title.text = _title
        addChild(@title);

        EventSDK.addEvent("onMouseTakeFocus",   method(:OnWinTakeFocus))
        EventSDK.addEvent("onMouseLostFocus",   method(:OnWinLostFocus))
        EventSDK.addEvent("onMouseRealese", method(:OnWinClose))

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
            SndLib.sys_ok
            self.visible = false;
        end
    end
    def OnWinTakeFocus(element)
        if element == @close
            @close.childs[0].color = Color.new(255, 0, 0, 255) if @close.childs[0].color != ViewSDK::FOCUS_COLOR;
            SndLib.play_cursor
        end
    end
    def OnWinLostFocus(element)
        if element == self
            @canRender = false
        end
        if element == @close
            @close.childs[0].color = Color.new(255, 255, 255, 255) if @close.childs[0].color != ViewSDK::IDLE_COLOR;
        end
    end
    #--------------------------------------------------
    # * ...
    #--------------------------------------------------
end

#$GlovalWinTest = CWindow.new(CVector2.new(200,160), "'Write your title'", true, true);
#Все работает заебись. Надо только пофиксить CView с его позишен
