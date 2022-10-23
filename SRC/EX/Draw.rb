#make new font
newFont = Font.new()
newFont.name = System_Settings::MESSAGE_WINDOW_FONT_NAME
newFont.bold = false
newFont.size = 15
newFont.outline = false
newFont.color = Color.new(245, 213, 39, 255);
#make new draw
$GlobalTextTest = CDraw.new(CVector2.new(120, 14), "100.0%")
#set new font
$GlobalTextTest.font = newFont;
#set text
$GlobalTextTest.setText("hey fuck 100.0%")
#set position
$GlobalTextTest.setPosition(284, 315)
#set priority vis
$GlobalTextTest.setOrder($GlobalTextTest.order+1)

#YOU NOT NEED UPDATED IT EVERYTIME