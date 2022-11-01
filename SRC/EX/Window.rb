# OLD AND SHITY CODE

$FuckWindow = CWindow.new("Window Test", true, 1125)
#$FuckWindow.setPosition(200, 40)

EventSDK.addEvent("onMouseRealese", $FuckWindow.method(:OnClose))
EventSDK.addEvent("onMousePressed", $FuckWindow.method(:OnPressedMovement))
EventSDK.addEvent("onMouseRealese", $FuckWindow.method(:OnRealeseMovement))
EventSDK.addEvent("onRender",       $FuckWindow.method(:OnRender))