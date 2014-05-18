import XMonad

main = xmonad $ defaultConfig
  { borderWidth = 2
  , terminal    = "terminology"
  , normalBorderColor = "#dc322f"
  , focusedBorderColor = "#859900" }
