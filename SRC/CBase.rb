#==============================================================================
# ** Base class
# **
# ** Author: DocNight
#------------------------------------------------------------------------------
#  This file contain class object                        
#==============================================================================

NULL = 0;

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
    def initialize(_parent = NULL, _childs = NULL, _x = 0, _y = 0, _size_x = 0, _size_y = 0)
        @parent         = _parent;
        @childs         = _childs;
    end
    #--------------------------------------------------
    # * Deconstructor
    #--------------------------------------------------
    def dispose
        return if @childs == NULL || @childs == nil

        @childs.each.with_index(0) do |key, value|
            @childs[key].setParent(NULL);
            @childs[key].dispose
            @childs[key] = nil;
            @childs.sort;
        end
    end
    #--------------------------------------------------
    # * Set parent for object
    #    _parent : class object
    #--------------------------------------------------
    # REMEMBER. There he used iherit element
    def setParent(_parent = NULL)
        #if _parent != NULL && _parent != nil
        #    @sprite.x = @position.x + _parent.sprite.x;
        #    @sprite.y = @position.y + _parent.sprite.y;
        #end
        @parent = _parent;
    end
    #--------------------------------------------------
    # * Add new child for object
    #    _child : class object
    #--------------------------------------------------
    def addChild(_child = NULL)
        if _child == NULL || _child == nil
            return
        end
        if @childs == nil || @childs == NULL
            @childs = [];
        end

        @childs << _child;
        _child.setParent(self);
    end
    #--------------------------------------------------
    # * Remove child for object
    #    _child : class object
    #--------------------------------------------------
    def removeChild(_child = NULL)
        if _child == NULL || _child == nil
            return
        end
        if @childs == nil || @childs == NULL
            return
        end

        @childs.each.with_index(0) do |key, value|
            if value == _child
                @childs[key] = nil;
                @childs.sort;
                _child.setParent(NULL);
            end
        end
    end

end