#==============================================================================
# ** Objects container and small managment
# **
# ** Author: DocNight
#------------------------------------------------------------------------------
#  This file contain class object                        
#==============================================================================

module ViewSDK

    DEFAULT_WINDOW_Z = 1125

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

        @background = Window_Base.new(0, 0, _size.x, _size.y);

        newFont = Font.new()
        newFont.name = System_Settings::MESSAGE_WINDOW_FONT_NAME
        newFont.bold = false
        newFont.size = 14
        newFont.outline = false
        newFont.color = Color.new(255, 255, 255, 255);

        @pX = 0;
        @pY = 0;
        @canRender = false;

        #@sprite.bitmap = Cache.normal_bitmap("Graphics/System/Window") 
        #@sprite.bitmap = Cache.normal_bitmap("#{MYUI_FOLDER}SRC/EX/window");
        @sprite.bitmap = Bitmap.new(32, 32);

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

        @title = CDraw.new(CVector2.new(180, 10), "Window Moveable Test", _z + 1);
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

    def OnClose(arg)
        if arg[1] == @close
            #msgbox "ts"
            self.visible = false;
        end
    end

    def OnPressedMovement(arg)
        if arg[1] == self
            @canRender = true
            @pX = Mouse.pos?[0] - @position.x;
            @pY = Mouse.pos?[1] - @position.y;
        end
    end

    def OnRealeseMovement(arg)
        if arg[1] == self
            @canRender = false
        end
    end

    def OnRender(arg)
        if @canRender == true && @moveable == true
            #prp "Can Movveeee", 5
            self.position = CVector2.new(Mouse.pos?[0]-@pX, Mouse.pos?[1]-@pY);
        end
    end

    def moveable=(_toggle)
        @moveable = _toggle;
    end
    def position=(_coord)
        if @parent == NULL || @parent == nil
            @sprite.x = _coord.x;
            @sprite.y = _coord.y;
            @background.x = _coord.x;
            @background.y = _coord.y;
            @position = _coord;
        else
            @sprite.x = @parent.sprite.x + _coord.x;
            @sprite.y = @parent.sprite.y + _coord.y;
            @background.x = @parent.sprite.x + _coord.x;
            @background.y = @parent.sprite.y + _coord.y;
            @position = _coord;
        end

        UpdateChildPosition()
    end
end

#$GlovalWinTest = CWindow.new(CVector2.new(200,120), "fuck yea", true, true);
#Все работает заебись. Надо только пофиксить CView с его позишен
