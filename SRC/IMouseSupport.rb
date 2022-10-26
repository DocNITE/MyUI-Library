#==============================================================================
# ** Add mouse event listener
# **
# ** Author: DocNight
#------------------------------------------------------------------------------
#  This file contain inject method/class object                        
#==============================================================================

class Event

    attr_accessor :name; 
    attr_accessor :addr; 

    def initialize(_name, _addrArr = [])
        @name = _name;
        @addr = _addrArr;
    end

    def addAddr(func)
        @addr[@addr.length()] = func;
    end

    def callAddr(arg=0)
        @addr.each {|event| 
            event.call(arg);
        }
    end
end

module EventSDK

    EVENTS = [];

    def self.addEvent(name, func);
        if !EVENTS.empty?
            EVENTS.each {|event| 
                if event.name == name
                    #msgbox name + " Hey wtf man"
                    event.addAddr(func);
                    return;
                end
            }

            nClass = Event.new(name, [func]);
            EVENTS[EVENTS.length()] = nClass;
        else
            nClass = Event.new(name, [func]);
            EVENTS[0] = nClass;
        end
    end

    def self.callEvent(name, arg=0);
        EVENTS.each {|event| 
            if event.name == name
                event.callAddr(arg);
                return;
            end
        }
    end

end

# Mouse
$PreviousElement = nil;
$PreviousButton = false;
MAX_UI_MD_ELEMENTS = 64;
module MouseDetector

    MB_IDLE    = 0;
    MB_FOCUSED = 1;
    MB_PRESSED = 2;

    MB_LEFT     = 0;
    MB_MIDLE    = 1;
    MB_RIGHT    = 2;
    MB_NONE     = 3;

    DETECTORS = Array.new(MAX_UI_MD_ELEMENTS);

    def self.add(elem);
        for i in 0..MAX_UI_MD_ELEMENTS-1 do
            if DETECTORS[i] == nil
                DETECTORS[i] = elem;
                break
            end
        end
    end

    def self.remove(elem);
        for i in 0..MAX_UI_MD_ELEMENTS-1 do
            if DETECTORS[i] == elem
                DETECTORS[i] = nil;
                break
            end
        end
    end

end

#Inject

#Input.trigger?(:MZ_LINK) left
#Input.trigger?(:MX_LINK) right

module Input
    def self.MouseButtonPressed? 
		return 0 if self.press?(:LBUTTON)
		return 2 if self.press?(:RBUTTON)
		return 1 if self.press?(:MBUTTON)
		return 3
	end
end

MX = 0;
MY = 1;

class Scene_Base

	alias myui_mouse_detector update_basic
	def update_basic
		myui_mouse_detector

        EventSDK.callEvent("onRender");

        #return Mouse.ForceIdle if Input.MouseWheelForceIdle?  
		return if !Mouse.enable?

        # Check elements, and check his order
        # And wtf? Why this loop make timer so slowly? Idk
        local_Element = -1;
        for i in 0..MAX_UI_MD_ELEMENTS-1 do
            next if MouseDetector::DETECTORS[i] == nil
            if (local_Element == -1 || MouseDetector::DETECTORS[i].order > local_Element.order) && 
                (MouseDetector::DETECTORS[i].visible == true) &&
                (MouseDetector::DETECTORS[i].within(Mouse.pos?[MX], Mouse.pos?[MY]))

                local_Element = MouseDetector::DETECTORS[i];
            end
        end

        if local_Element == -1 || local_Element == $GlobalButtonNotEditPls
            if $PreviousElement != nil
                $PreviousElement.update([3, MouseDetector::MB_IDLE]);
                $PreviousElement = nil;
                $PreviousButton = false;
            end
            return
        end

        if $PreviousElement != nil && $PreviousElement != local_Element
            $PreviousElement.update([3, MouseDetector::MB_IDLE]);
            $PreviousElement = nil;
            $PreviousButton = false;
        end

        local_Id = Input.MouseButtonPressed?;

        if $PreviousElement != local_Element
            if local_Id < 3
                EventSDK.callEvent("onMouseFocus", [true, local_Id, local_Element]);
            else
                EventSDK.callEvent("onMouseFocus", [false, local_Id, local_Element]);
            end
        else
            if $PreviousElement.prevMbId[1] == MouseDetector::MB_PRESSED
                if local_Id == 3 && $PreviousButton == true
                    $PreviousButton = false
                    EventSDK.callEvent("onMouseRealese", [$PreviousElement.prevMbId[0], local_Element]);
                end
            elsif $PreviousElement.prevMbId[1] == MouseDetector::MB_FOCUSED
                if local_Id < 3 && $PreviousButton == false
                    $PreviousButton = true;
                    EventSDK.callEvent("onMousePressed", [local_Id, local_Element]);
                end
            end
        end

        if local_Id < 3
            local_Element.update([local_Id, MouseDetector::MB_PRESSED]);
        else
            local_Element.update([local_Id, MouseDetector::MB_FOCUSED]);
        end

        $PreviousElement = local_Element;
        # When we give neede elem, now time to check mouse state
        
	end

end


=begin
def fuckMeMan(arg)
    msgbox "test"
end

EventSDK.addEvent("OnInit", method(:fuckMeMan))
EventSDK.callEvent("OnInit")
=end