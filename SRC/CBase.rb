#==============================================================================
# ** Base class
# **
# ** Author: DocNight
#------------------------------------------------------------------------------
#  This file contain class object                        
#==============================================================================

#2d pos class
class CBase
    #--------------------------------------------------
    # * Public attributes
    #--------------------------------------------------
    attr_reader     :parent     ;  # Parent this object
    attr_reader     :childs     ;  # Children objects
    #--------------------------------------------------
    # * Constructor
    #--------------------------------------------------
    def initialize(_parent = nil, _childs = [], _x = 0, _y = 0, _size_x = 0, _size_y = 0)
        @parent         = _parent;
        @childs         = _childs;
    end
    #--------------------------------------------------
    # * Deconstructor
    #--------------------------------------------------
    def dispose
        @childs.each.with_index(0) do |key, value|
            @childs[key].setParent(nil);
            @childs[key].dispose
            @childs[key] = nil;
            @childs.sort;
        end
    end
    #--------------------------------------------------
    # * Set parent for object
    #    _parent : class object
    #--------------------------------------------------
    def setParent(_parent = -1)
        if _parent == -1
            return
        end

        @parent = _parent;
    end
    #--------------------------------------------------
    # * Add new child for object
    #    _child : class object
    #--------------------------------------------------
    def addChild(_child = -1)
        if _child == -1
            return
        end
        if @childs == nil
            @childs = [];
        end

        @childs << _child;
        _child.setParent(self);
    end
    #--------------------------------------------------
    # * Remove child for object
    #    _child : class object
    #--------------------------------------------------
    def removeChild(_child = -1)
        if _child == -1
            return
        end
        if @childs == nil
            return
        end

        @childs.each.with_index(0) do |key, value|
            if value == _child
                @childs[key] = nil;
                @childs.sort;
                _child.setParent(nil);
            end
        end
    end

end