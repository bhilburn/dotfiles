--
-- File     : ~/.xmonad/xmonad.hs (for Xmonad >= 0.9)
-- Author   : Thayer Williams
-- Website  : http://cinderwick.ca/
-- Desc     : A mininal xmonad config geared towards
--            netbooks and other low-resolution devices.
--

import XMonad
import XMonad.Actions.CycleWindows -- classic alt-tab
import XMonad.Actions.CycleWS      -- cycle thru WS', toggle last WS
import XMonad.Actions.DwmPromote   -- swap master like dwm
import XMonad.Hooks.DynamicLog     -- statusbar 
import XMonad.Hooks.ManageDocks    -- dock/tray mgmt
import XMonad.Hooks.UrgencyHook    -- window alert bells 
import XMonad.Layout.Named         -- custom layout names
import XMonad.Layout.NoBorders     -- smart borders on solo clients
import XMonad.Util.EZConfig        -- append key/mouse bindings
import XMonad.Util.Run(spawnPipe)  -- spawnPipe and hPutStrLn
import System.IO                   -- hPutStrLn scope
import System.Posix.IO
import System.Posix.Process (executeFile, forkProcess, createSession)

import qualified XMonad.StackSet as W   -- manageHook rules

main = do
        status <- spawnPipe myDzenStatus    -- xmonad status on the left
        conky  <- spawnPipe myDzenConky     -- conky stats on the right
        xmonad $ withUrgencyHook NoUrgencyHook $ defaultConfig 
            { modMask            = mod4Mask
            , terminal           = "urxvtc"
            , borderWidth        = 2
            , normalBorderColor  = "#dddddd"
            , focusedBorderColor = "#0000ff"
            , workspaces = myWorkspaces
            , layoutHook = myLayoutHook
            , manageHook = manageDocks <+> myManageHook
                            <+> manageHook defaultConfig
            , logHook    = myLogHook status
            } 
            `additionalKeysP` myKeys
            `additionalMouseBindings` myButtons

-- Tags/Workspaces
myWorkspaces            = ["Bow","Port","Starboard","Stern","Launch","Dock"]

-- Layouts
-- the default layout is fullscreen with smartborders applied to all
myLayoutHook = avoidStruts $ smartBorders ( full ||| mtiled ||| tiled )
  where
    full    = named "X" $ Full
    mtiled  = named "MT" $ Mirror tiled
    tiled   = named "T" $ Tall 1 (5/100) (2/(1+(toRational(sqrt(5)::Double))))
    -- sets default tile as: Tall nmaster (delta) (golden ratio)

-- Window management
--
myManageHook = composeAll
    [ className =? "URxvt"                          --> unfloat
    , className =? "trayer"                         --> doIgnore
    , resource  =? "desktop_window"                 --> doIgnore
    , resource  =? "kdesktop"                       --> doIgnore ]
    <+> doFloat <+> manageDocks
    where unfloat = ask >>= doF . W.sink

-- Statusbar 
--
myLogHook handle = dynamicLogWithPP $ myDzenPP { ppOutput = hPutStrLn handle }

myDzenStatus = "dzen2 -x '0' -y '0' -w '600' -ta 'l'" ++ myDzenStyle
myDzenConky  = "conky -c ~/.xmonad/conkyrc | dzen2 -x '600' -w '920' -ta 'r'" ++ myDzenStyle
myDzenStyle  = " -h '16' -fg '#777777' -bg '#222222' -fn '-*-terminus-*-r-normal-*-*-*-*-*-*-*-iso8859-*'"

myDzenPP = dzenPP
    { ppCurrent = dzenColor "#3399ff" "" . wrap " " " "
    , ppHidden  = dzenColor "#dddddd" "" . wrap " " " "
    , ppHiddenNoWindows = dzenColor "#777777" "" . wrap " " " "
    , ppUrgent  = dzenColor "#ff0000" "" . wrap " " " "
    , ppSep     = "   "
    , ppLayout  = dzenColor "#aaaaaa" "" . wrap "·" "·"
    , ppTitle   = dzenColor "#ffffff" "" . shorten 150
    }


-- Key bindings
--
myKeys = [ ("M-b"        , sendMessage ToggleStruts              ) -- toggle the status bar gap
         , ("M1-<Tab>"   , cycleRecentWindows [xK_Alt_L] xK_Tab xK_Tab ) -- classic alt-tab behaviour
         , ("M-<Return>" , dwmpromote                            ) -- swap the focused window and the master window
         , ("M-<Tab>"    , toggleWS                              ) -- toggle last workspace (super-tab)
         , ("M-<Right>"  , nextWS                                ) -- go to next workspace
         , ("M-<Left>"   , prevWS                                ) -- go to prev workspace
         , ("M-S-c"      , kill                                  ) -- close a focused window
         , ("M-S-<Right>", shiftToNext                           ) -- move client to next workspace
         , ("M-S-<Left>" , shiftToPrev                           ) -- move client to prev workspace
         , ("M-t"        , withFocused $ windows . W.sink        ) -- push a window back into the tiled space
         , ("M-p"        , spawn "exe=`dmenu_run | dmenu -nb '#3f3f3f' -sb '#dcdccc' -sf '#070806'` && eval \"exec $exe\"")
         , ("M-r"        , spawn "xmonad --restart"              ) -- restart xmonad w/o recompiling
         , ("M-w"        , spawn "chromium"                      ) -- launch browser
         , ("M-S-w"      , spawn "chromium --incognito"          ) -- launch private browser
         , ("M-e"        , spawn "nautilus"                      ) -- launch file manager
         , ("C-M1-l"     , spawn "gnome-screensaver-command --lock"              ) -- lock screen
         , ("C-M1-<Delete>" , spawn "sudo shutdown -r now"       ) -- reboot
         , ("C-M1-<Insert>" , spawn "sudo shutdown -h now"       ) -- poweroff
         ]

-- Mouse bindings
--
myButtons = [ ((0, 8), (\_ -> prevWS )) -- cycle workspaces 
            , ((0, 9), (\_ -> nextWS )) -- with thumb buttons 
            ]

