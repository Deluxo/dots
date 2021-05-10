{-# OPTIONS_GHC -fwarn-unused-imports -fno-warn-missing-signatures #-}

import XMonad
import System.IO
import qualified XMonad.StackSet as W
import XMonad.Actions.CopyWindow
import XMonad.Actions.CycleWS
import XMonad.Hooks.DynamicLog
import XMonad.Hooks.EwmhDesktops
import XMonad.Hooks.ManageDocks
import XMonad.Hooks.ManageHelpers
import XMonad.Layout.ResizableTile
import XMonad.Layout.MultiColumns
import XMonad.Layout.NoBorders
import XMonad.Layout.Spacing
import XMonad.Util.EZConfig (additionalKeys)
import XMonad.Util.Run (spawnPipe)
import Graphics.X11.ExtraTypes.XF86

term = "kitty"
myGap = 25
main = do
    xmproc <- spawnPipe "xmobar ~/.xmonad/xmobarrc"
    xmonad $ ewmh $ docks $ myConfig xmproc

myConfig xmproc = def {
   terminal = term
   , modMask = mod4Mask
   , focusedBorderColor = color8
   , borderWidth = 3
   , normalBorderColor =  color7
   , startupHook = myStartuphook
   , handleEventHook = handleEventHook def <+> docksEventHook <+> fullscreenEventHook
   --, manageHook = myManageHook  <+> manageHook def <+> namedScratchpadManageHook scratchpads
   , manageHook = myManageHook  <+> manageHook def
   , layoutHook =  myLayouts
   , logHook = dynamicLogWithPP xmobarPP
       {
       ppOutput = hPutStrLn xmproc
       , ppTitle = xmobarColor color0  "" . shorten 80
       , ppCurrent = xmobarColor color0 ""
       , ppHiddenNoWindows = xmobarColor color77 ""
       , ppHidden = xmobarColor color8 ""
       , ppLayout = const ""
       }
   }
   `additionalKeys` myKeys

myKeys =
    [ ((mod4Mask, xK_d), spawn "rofi -show combi")
    , ((mod4Mask, xK_s), spawn (term ++ " -e spt"))
    , ((mod4Mask, xK_m), spawn (term ++ " -e neomutt"))
    , ((mod4Mask, xK_p), spawn (term ++ " -e pulsemixer"))
    , ((mod4Mask, xK_Return), spawn term)
    , ((mod4Mask+shiftMask, xK_q), kill)
    , ((mod4Mask, xK_q), kill)
    , ((mod4Mask, xK_r), restart "xmonad" True)
    , ((0, xF86XK_AudioLowerVolume), spawn "pactl set-sink-volume @DEFAULT_SINK@ -5%")
    , ((0, xF86XK_AudioRaiseVolume), spawn "pactl set-sink-volume @DEFAULT_SINK@ +5%")
    , ((0, xF86XK_AudioMute), spawn "pactl set-sink-mute @DEFAULT_SINK@ toggle")
    , ((0, xF86XK_AudioPlay), spawn "playerctl play-pause")
    , ((0, xF86XK_AudioStop), spawn "playerctl play-pause")
    , ((0, xF86XK_AudioNext), spawn "playerctl next")
    , ((0, xF86XK_AudioPrev), spawn "playerctl previous")
    , ((0, xF86XK_AudioMicMute), spawn "pactl set-source-mute alsa_input.pci-0000_06_00.6.analog-stereo toggle")
    , ((0, xK_Print), spawn "flameshot launcher")
    , ((mod4Mask, xK_c), spawn "~/.scripts/./context-runner.sh")
    , ((mod4Mask+shiftMask, xK_t), spawn (term ++ " --class='term-cal' --title 'Term Cal' -o window_padding_width=50 -o font_size=17 -o cursor_shape=underline -o cursor_stop_blinking_after=1 -o cursor_underline_thickness=0 sh -c '/usr/bin/cal -3w && read && exit'"))
    , ((mod4Mask, xK_bracketright), nextWS)
    , ((mod4Mask, xK_bracketleft), prevWS)
    , ((mod4Mask, xK_Tab), toggleWS)
    , ((mod4Mask, xK_v), windows copyToAll)
    , ((mod4Mask+shiftMask, xK_v), killAllOtherCopies)
    , ((mod4Mask+shiftMask, xK_a), spawn "~/.scripts/switch-audio-cards.sh monitor")
    , ((mod4Mask, xK_a), spawn "~/.scripts/switch-audio-cards.sh")
    --, ((mod4Mask+shiftMask, xK_h), namedScratchpadAction scratchpads "feh")
    , ((mod4Mask+shiftMask, xK_h), sendMessage MirrorShrink)
    , ((mod4Mask+shiftMask, xK_l), sendMessage MirrorExpand)
    ]

myManageHook = composeAll
    [
        className =? "term-cal" --> doRectFloat (W.RationalRect 0.3 0.35 0.34 0.28)
       ,className =? "float-center" --> doCenterFloat
       ,className =? "hl_linux" --> doFloat
    ]
    --[ className =? "" --> doShiftAndGo (myWorkspaces !! 4)    -- Spotify f***ed up once more
    --,className =? "Firefox" --> doShiftAndGo (myWorkspaces !! 1)
    --,className =? "Thunderbird" --> doShiftAndGo (myWorkspaces !! 3)
    --,className =? "Thunar" --> doFloat
    --,className =? "TelegramDesktop" --> doRectFloat (W.RationalRect (0) (1%2) (1%5) (1%2))
    --,className =? "Signal" --> doRectFloat (W.RationalRect (0) (1%2) (4%10) (1%2))
    --]
        --where
            --doShiftAndGo w  = doF (W.greedyView w) <+> doShift w

myGaps = spacingRaw
    True             -- Only for >1 window
    (Border myGap myGap myGap myGap) -- Size of screen edge gaps (Border top bottom right left)
    True             -- Enable screen edge gaps
    (Border myGap myGap myGap myGap) -- Size of window gaps
    True             -- Enable window gaps

myLayouts =
    layoutColumns ||| layoutFull where
            layoutColumns = smartBorders $ avoidStruts $ myGaps $ multiCol [1] 2 0.01 (-0.5)
            layoutFull = smartBorders $ Full

xmobarEscape :: String -> String
xmobarEscape = concatMap doubleLts
  where
        doubleLts '<' = "<<"
        doubleLts x   = [x]

-- startup hook
myStartuphook :: X ()
myStartuphook = do
    spawn "nitrogen --restore"
    spawn "xsetroot -cursor_name Left_ptr"
    spawn "picom"


color0 = "#f7f9fb"
color1 = "#bf8b56"
color2 = "#56bf8b"
color3 = "#8bbf56"
color4 = "#8b56bf"
color5 = "#bf568b"
color6 = "#568bbf"
color7 = "#405c79"
color77 = "#8091a5"
color8 = "#aabcce"
color9 = "#bf8b56"
color10 = "#56bf8b"
color11 = "#8bbf56"
color12 = "#8b56bf"
color13 = "#bf568b"
color14 = "#568bbf"
color15 = "#0b1c2c"

-- vim: ts=4 sw=4 et
