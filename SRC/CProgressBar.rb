#==============================================================================
# ** Statistic bar line
# **
# ** Author: DocNight
#------------------------------------------------------------------------------
#  This file contain class object                        
#==============================================================================

#2d line bar
class CStatusBar < CView
    #--------------------------------------------------
    # * Public attributes
    #--------------------------------------------------
    attr_accessor   :value;         # value               #TODO: Array val
    attr_accessor   :max_value;     # maximum value
    #--------------------------------------------------
    # * Private attributes
    #--------------------------------------------------
    attr_reader     :progressTex;   # progress line
    attr_reader     :backgroundTex; # background line
    #--------------------------------------------------
    # * Constructor
    #--------------------------------------------------
    def initialize(_value, _maxValue, _tex, _texBack, _z = System_Settings::MAP_HUD_Z)
        super(_z);
        
        # Define variables
        @value      = _value;
        @value      += 0.0;
        @max_value  = _maxValue;
        @max_value  += 0.0;
        # Define texture
        @progressTex    = _tex;
        addChild(@progressTex);
        @backgroundTex  = _texBack;
        addChild(@backgroundTex);

        blit
    end
    #--------------------------------------------------
    # * Deconstructor
    #--------------------------------------------------
    def dispose
        self.dispose
    end
    #--------------------------------------------------
    # * Update bar
    #--------------------------------------------------
    def blit
        per = (@value/@max_value)*100
        finaly = ((@backgroundTex.size.x * per) / 100).to_i;
        @progressTex.width = finaly;
    end
    #--------------------------------------------------
    # * Set Value
    #    _val : type Int
    #--------------------------------------------------
    def setValue(_val)
        self.value = _val;
    end
    #--------------------------------------------------
    # * Set Max Value
    #    _val : type Int
    #--------------------------------------------------
    def setMaxValue(_val)
        self.max_value = _val;
    end
    #--------------------------------------------------
    # * ...
    #--------------------------------------------------
    def value=(_val)
        @value = _val;
        if @value < 0
            @value = 0;
        end
        if @value > @max_value
            @value = @max_value;
        end
        @value += 0.0;
        blit
    end
    def max_value=(_val)
        if _val < 0
            _val = 0;
        end
        if _val < @value
            @value = _val;
        end
        @max_value = _val;
        @max_value += 0.0;
        blit
    end
end