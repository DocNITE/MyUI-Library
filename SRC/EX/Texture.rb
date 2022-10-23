#REMEMBER!!
# You can change VievSDK::TEXTURE_PATH for you path everytime, where you need!
# Just check CTexture.rb how it works. 
# And yeah, you can disable that feature

#make texture
$GlobalSpriteTest = CTexture.new(Rect.new(0, 0, 212, 42), "AchUlk")
#set position
$GlobalSpriteTest.position = CVector2.new(24, 24)
#also set position
$GlobalSpriteTest.setPosition(214, 300)
#transparent
$GlobalSpriteTest.opacity = 160