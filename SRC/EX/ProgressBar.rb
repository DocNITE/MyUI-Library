#Set texture path
#CAUTION: We can set classic path system, ex: "Graphics/Picture/Hud"
#Just set TEXTURE_PATH_MODE on 1
ViewSDK::TEXTURE_PATH = "ModScripts/_Mods/MyUI Library/SRC/EX/"
#Make progress and background texture
texc1 = CTexture.new(Rect.new(0, 0, 104, 4), "bar", 1122)
texc2 = CTexture.new(Rect.new(104, 0, 104, 4), "bar",  1121)
#Make bar class
$GlobalBarTest = CStatusBar.new(70, 100, texc1, texc2, 1120);
#Set position
#There we can replace all child object for bar position
#Its cool
$GlobalBarTest.setPosition(250, 310)

#Test
$timer = 0;
class Scene_Base
	alias ddsasdsd update_basic
	def update_basic
		ddsasdsd
        if $timer < 30
            $timer += 1
        else
            if $GlobalBarTest.value > 0
                $GlobalBarTest.value = $GlobalBarTest.value - 1
                #equalince: $GlobalBarTest.setValue($GlobalBarTest.value-1)
            else
                $GlobalBarTest.value = $GlobalBarTest.max_value
                #equalince: $GlobalBarTest.setValue($GlobalBarTest.max_value)
            end
            $timer = 0;
        end
	end
end