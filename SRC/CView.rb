#==============================================================================
# ** Base texture view object
# **
# ** Author: DocNight
#------------------------------------------------------------------------------
#  This file contain class object                        
#==============================================================================

class CView < CBase
    #--------------------------------------------------
    # * Public attributes
    #--------------------------------------------------
    attr_accessor :position             # XY position
    attr_accessor :size                 # XY size

    attr_accessor :order                # Priority

    attr_accessor :visible              # Visibility
    attr_accessor :color                # Color
    attr_accessor :opacity              # Transparent
    #--------------------------------------------------
    # * Private attributes
    #--------------------------------------------------
    attr_reader   :sprite               # Sprite object
    #--------------------------------------------------
    # * Constructor
    #--------------------------------------------------
    def initialize(_z = System_Settings::MAP_HUD_Z)
        @position   = CVector2.new(0, 0);
        @size       = CVector2.new(0, 0);
        # Order
        @order      = _z;
        # Visible
        @visible    = true;
        # Color
        @color      = Color.new(255, 255, 255);
        @opacity    = 1;
        # Define sprite
        @sprite        = Sprite.new();
        @sprite.x      = 0;
        @sprite.y      = 0;
        @sprite.z      = _z;
    end
    #--------------------------------------------------
    # * Deconstructor
    #--------------------------------------------------
    def dispose
        self.dispose
    end
    #--------------------------------------------------
    # * Set sprite rend. order
    #    _toggle : type Boolean
    #--------------------------------------------------
    def setVisible(_toggle)
        self.visible = _toggle;
    end
    #--------------------------------------------------
    # * Set sprite rend. order
    #    _alpha : type Int[0-255]
    #--------------------------------------------------
    def setOpacity(_alpha)
        self.opacity = _alpha;
    end
    #--------------------------------------------------
    # * Set sprite rend. order
    #    _order : type Int
    #--------------------------------------------------
    def setOrder(_order)
        self.order = _order;
    end
    #--------------------------------------------------
    # * Set Position Sprite
    #    _x : type Int
    #    _y : type Int
    #--------------------------------------------------
    def setPosition(_x, _y)
        self.position = CVector2.new(_x, _y);
    end
    #--------------------------------------------------
    # * Set Size Sprite
    #    _x : type Int
    #    _y : type Int
    #--------------------------------------------------
    def setSize(_x, _y)
        self.size = CVector2.new(_x, _y);
    end
    #--------------------------------------------------
    # * Update child object
    #--------------------------------------------------
    def UpdateChildPosition()
        if @childs == nil
            return
        end

        @childs.each.with_index(0) do |key, value|
            if value != nil
                @childs[value].position = @childs[value].position;
                #@childs[value].sprite.x = @sprite.x + @childs[value].position.x;
                #@childs[value].sprite.y = @sprite.y + @childs[value].position.y;
            end
        end
    end
    def UpdateChildSize()
        if @childs == nil
            return
        end

        @childs.each.with_index(0) do |key, value|
            if value != nil
                @childs[value].size = @size + @childs[value].size;
            end
        end
    end
    def UpdateChildVisible()
        if @childs == nil
            return
        end

        @childs.each.with_index(0) do |key, value|
            if value != nil
                @childs[value].visible = @visible;
            end
        end
    end
    def UpdateChildOpacity()
        if @childs == nil
            return
        end

        @childs.each.with_index(0) do |key, value|
            if value != nil
                @childs[value].opacity = @opacity;
            end
        end
    end
    #--------------------------------------------------
    # * ...
    #--------------------------------------------------
    def x=(_val)
        @sprite.x = _val;
        @position = CVector2.new(_val, @position.y);

        UpdateChildPosition()
    end
    def y=(_val)
        @sprite.y = _val;
        @position = CVector2.new(@position.x, _val);

        UpdateChildPosition()
    end
    def width=(_val)
        @sprite.src_rect.width = _val;
        @size =  CVector2.new(_val, @size.y);

        #UpdateChildSize()
    end
    def height=(_val)
        @sprite.src_rect.height = _val;
        @size = CVector2.new(@size.x, _val);

        #UpdateChildSize()
    end
    def position=(_coord)
        if @parent == NULL || @parent == nil
            @sprite.x = _coord.x;
            @sprite.y = _coord.y;
            @position = _coord;
        else
            @sprite.x = @parent.sprite.x + _coord.x;
            @sprite.y = @parent.sprite.y + _coord.y;
            @position = _coord;
        end

        UpdateChildPosition()
    end
    def size=(_coord)
        @sprite.src_rect.width = _coord.x;
        @sprite.src_rect.height = _coord.y;
        @size = _coord;

        #UpdateChildSize()
    end
    def color=(_col)
        @sprite.color = _col;
        @color = _col;
    end
    def opacity=(_val)
        @sprite.opacity = _val;
        @opacity = _val;
    end
    def order=(_order)
        @order = _order;
        @sprite.z = _order
    end
    def visible=(_toggle, _childs=true)
        @sprite.visible = _toggle;
        @visible = _toggle;

        if _childs == true
            UpdateChildVisible()
        end
    end
end