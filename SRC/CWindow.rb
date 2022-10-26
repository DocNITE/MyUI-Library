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
    attr_reader :close;
    attr_reader :title;
    #--------------------------------------------------
    # * Constructor
    #--------------------------------------------------
    def initialize(_title="", _close=true, _z = System_Settings::MAP_HUD_Z)
        _size = CVector2.new(180, 80);
        super(_size, _z)

        newFont = Font.new()
        newFont.name = System_Settings::MESSAGE_WINDOW_FONT_NAME
        newFont.bold = false
        newFont.size = 10
        newFont.outline = false
        newFont.color = Color.new(255, 255, 255, 255);

        @pX = 0;
        @pY = 0;
        @canRender = false;

        #@sprite.bitmap = Cache.normal_bitmap("Graphics/System/Window") 
        @sprite.bitmap = Cache.normal_bitmap("#{MYUI_FOLDER}SRC/EX/window");

        @close = CButton.new(CVector2.new(24, 24), false, false, false, _z + 1);

        newFont2 = Font.new()
        newFont2.name = System_Settings::MESSAGE_WINDOW_FONT_NAME
        newFont2.bold = false
        newFont2.size = 24
        newFont2.outline = false
        newFont2.color = Color.new(255, 255, 255, 255);

        closeText = CDraw.new(CVector2.new(24, 24), "X", _z + 2);
        closeText.alligment = 1;
        closeText.setPosition(0, 0);
        closeText.font = newFont2;
        closeText.text = "X"
        @close.addChild(closeText);
        @close.setPosition(150, 6)
        addChild(@close);

        @title = CDraw.new(CVector2.new(180, 10), "Window Moveable Test", _z + 1);
        @title.setPosition(4, 4);
        @title.font = newFont;
        @title.text = "417_window_moveable_test"
        addChild(@title);

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
        #msgbox "wtf"
        #prp "che za nah", 4
        #msgbox "#{arg[2]}"
        if arg[1] == self
           #prp "Can render", 5
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
        if @canRender == true
            #prp "Can Movveeee", 5
            self.position = CVector2.new(Mouse.pos?[0]-@pX, Mouse.pos?[1]-@pY);
        end
    end
end


#Все работает заебись. Надо только пофиксить CView с его позишен
