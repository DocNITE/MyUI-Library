#==============================================================================
# ** Main entry file
# **
# ** Author: DocNight
#------------------------------------------------------------------------------
#  This file connect all scripts, what exist in '/src' folder.                            
#==============================================================================
 
#Define
MYUI_NAME          = "MyUI Library";
MYUI_FOLDER        = "ModScripts/_Mods/" + MYUI_NAME + "/";

MYUI_VERSION = "0.1"

# include script file
def import(path, file)
    load_script("ModScripts/_Mods/" + path + "/" + file);
end

#---------------------------------------------------------
# * Constants
#---------------------------------------------------------
import(MYUI_NAME, "SRC/Global.rb");
#---------------------------------------------------------
# * Dev Types
#---------------------------------------------------------
import(MYUI_NAME, "SRC/CBase.rb");
import(MYUI_NAME, "SRC/CView.rb");
import(MYUI_NAME, "SRC/CVector2.rb");
import(MYUI_NAME, "SRC/CTexture.rb");
import(MYUI_NAME, "SRC/CDraw.rb");
#---------------------------------------------------------
# * UI
#---------------------------------------------------------
import(MYUI_NAME, "SRC/CProgressBar.rb");

#---------------------------------------------------------
# * EXAMPLES/TEST
#    Dont forget disable it shit!
#---------------------------------------------------------
#import(MYUI_NAME, "SRC/EX/Texture.rb");
#import(MYUI_NAME, "SRC/EX/Draw.rb");

#import(MYUI_NAME, "SRC/EX/ProgressBar.rb");