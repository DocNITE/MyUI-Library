#==============================================================================
# ** 2D coordinate class
# **
# ** Author: DocNight
#------------------------------------------------------------------------------
#  This file contain class object                        
#==============================================================================

#2d pos class
class CVector2
    #public:
    attr_accessor :x; # X - coordinate
    attr_accessor :y; # Y - coordinate

    def initialize(_x, _y)
        if _x == nil
            @x = 0;
        else
            @x = _x;
        end
        if _y == nil
            @y = 0;
        else
            @y = _y;
        end
    end

    def +(second)
        CVector2.new(@x + second.x, @y + second.y);
    end
    def -(second)
        CVector2.new(@x - second.x, @y - second.y);
    end
    def -(second)
        @x -= second.x;
        @y -= second.y;
    end
    def *(second)
        CVector2.new(@x * second.x, @y * second.y);
    end
    def /(second)
        CVector2.new(@x / second.x, @y / second.y);
    end

    def toString(second)
        return "{#{@x}, #{@y}}";
    end

end