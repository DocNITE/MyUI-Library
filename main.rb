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
def import(file)
    load_script(MYUI_FOLDER + file);
end

#---------------------------------------------------------
# * Constants
#---------------------------------------------------------
import("SRC/Global.rb");
#---------------------------------------------------------
# * Dev Library
#---------------------------------------------------------
import("SRC/IMouseSupport.rb");
#---------------------------------------------------------
# * Dev Types
#---------------------------------------------------------
import("SRC/CBase.rb");
import("SRC/CView.rb");
import("SRC/CVector2.rb");
import("SRC/CTexture.rb");
import("SRC/CDraw.rb");
#---------------------------------------------------------
# * UI
#---------------------------------------------------------
import("SRC/CElement.rb");
import("SRC/CWindow.rb");
import("SRC/CButton.rb");
import("SRC/CProgressBar.rb");

#---------------------------------------------------------
# * EXAMPLES/TEST
#    Dont forget disable it shit!
#---------------------------------------------------------
#import("SRC/EX/Texture.rb");
#import("SRC/EX/Draw.rb");

#import("SRC/EX/ProgressBar.rb");
import("SRC/EX/Window.rb");