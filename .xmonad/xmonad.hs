import XMonad
import XMonad.Util.Run(spawnPipe)
import XMonad.Hooks.DynamicLog
import XMonad.Hooks.ManageDocks
import XMonad.Layout.Decoration
import System.IO

-- Solarized Colors
base03  = "#002b36"
base02  = "#073642"
base01  = "#586e75"
base00  = "#657b83"
base0   = "#839496"
base1   = "#93a1a1"
base2   = "#eee8d5"
base3   = "#fdf6e3"
yellow  = "#b58900"
orange  = "#cb4b16"
red     = "#dc322f"
magenta = "#d33682"
violet  = "#6c71c4"
blue    = "#268bd2"
cyan    = "#2aa198"
green   = "#719e07"

myNormalBorderColor   = "#000000"
myFocusedBorderColor  = base03
myBorderWidth         = 0

active = green

baseTheme :: Theme
baseTheme = defaultTheme
    { activeColor           = base03
    , activeBorderColor     = base03
    , activeTextColor       = base01 -- blue also good
    , inactiveBorderColor   = base02
    , inactiveColor         = base02
    , inactiveTextColor     = base01
    , urgentColor           = yellow
    , urgentBorderColor     = yellow
    , urgentTextColor       = base02
    -- , decoHeight            = 22
    , decoHeight            = 20
    }

tabThemeDim :: Theme
tabThemeDim = baseTheme
    { -- base00, base01, blue all good activeColors
      activeColor           = base03
    , activeBorderColor     = base03
    , activeTextColor       = base01
    }

tabTheme :: Theme
tabTheme = baseTheme
    { -- base00, base01, blue all good activeColors
      activeColor           = active
    , activeBorderColor     = base03 
    , activeTextColor       = base03
    }

tileTheme :: Theme
tileTheme = baseTheme
    { -- base00, base01, blue all good activeColors
      activeColor           = base01
    , activeBorderColor     = base01
    , activeTextColor       = base03
    }

altTileTheme :: Theme
altTileTheme = baseTheme
    { -- base00, base01, blue all good activeColors
      activeColor           = active
    , activeBorderColor     = active
    , activeTextColor       = base03
    }

config = xmonad $ defaultConfig

myPP = defaultPP
    { ppHidden            = id
    , ppHiddenNoWindows   = const ""
    , ppSep               = " : "
    , ppWsSep             = " "
    , ppLayout            = id
    , ppOrder             = id
    , ppOutput            = putStrLn xmproc
    , ppExtras            = []
    }

main = do
  xmproc <- spawnPipe "/usr/bin/xmobar ~/.xmobarrc"
  xmonad $ defaultConfig
    { borderWidth         = 2
    , terminal            = "terminology"
    , normalBorderColor   = myNormalBorderColor
    , focusedBorderColor  = myFocusedBorderColor
    , focusFollowsMouse   = False
    , clickJustFocuses    = False
    , manageHook = manageDocks <+> manageHook defaultConfig
    , layoutHook = avoidStruts  $  layoutHook defaultConfig
    , logHook = dynamicLogWithPP xmobarPP
                    { ppOutput = hPutStrLn xmproc
                    , ppCurrent = xmobarColor base02 active . wrap " " " "
                    , ppTitle = xmobarColor active "" . shorten 40
                    , ppVisible = wrap "(" ")"
                    , ppUrgent  = xmobarColor base02 yellow . wrap " " " "
                    }
    }
