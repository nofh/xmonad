--
-- xmonad example config file for xmonad-0.9
--
-- A template showing all available configuration hooks,
-- and how to override the defaults in your own xmonad.hs conf file.
--
-- Normally, you'd only override those defaults you care about.
--
-- NOTE: Those updating from earlier xmonad versions, who use
-- EwmhDesktops, safeSpawn, WindowGo, or the simple-status-bar
-- setup functions (dzen, xmobar) probably need to change
-- xmonad.hs, please see the notes below, or the following
-- link for more details:
--
-- http://www.haskell.org/haskellwiki/Xmonad/Notable_changes_since_0.8
--
 
import XMonad hiding ( (|||) )

import XMonad.Hooks.DynamicLog
import XMonad.Hooks.ManageDocks
import XMonad.Hooks.ManageHelpers

import XMonad.Layout.LayoutCombinators
import XMonad.Layout.Named

import XMonad.Layout.Spiral 
import XMonad.Layout.Tabbed 
import XMonad.Layout.Accordion 
import XMonad.Layout.Mosaic 

import XMonad.Actions.WindowGo (runOrRaise)

import Data.Monoid
import System.Exit
 
import qualified XMonad.StackSet as W
import qualified Data.Map        as M
 
-- The preferred terminal program, which is used in a binding below and by
-- certain contrib modules.
--
myTerminal      = "terminator"

web1            = "iceweasel"
web2            = "google-chrome"
web3            = "uzlb-browser"

editeur         = "gvim"
calculatrice    = "gcalctool"
navigateur_fichier = "nautilus --no-desktop"

volume_mute     = "amixer sset Master,0 toggle"
volume_more     = "amixer set Master 5+ unmute" 
volume_less     = "amixer set Master 5- unmute"

musique         = "audacious"
video           = "vlc"

aide            = "~/.xmonad/bin/aide.sh"

------------------------------------------------------------------------
-- Border colors for unfocused and focused windows, respectively.
--
myFocusedBorderColor  = "#1014e0"
myNormalBorderColor = "#a9abf9"

-- Color of current window title in xmobar.
xmobarTitleColor = "#7abaf5"

-- Color of current workspace in xmobar.
xmobarCurrentWorkspaceColor = "#107ce0" 

-- Width of the window border in pixels.
myBorderWidth = 1

-- Whether focus follows the mouse pointer.
myFocusFollowsMouse :: Bool
myFocusFollowsMouse = True
 
 
-- modMask lets you specify which modkey you want to use. The default
-- is mod1Mask ("left alt").  You may also consider using mod3Mask
-- ("right alt"), which does not conflict with emacs keybindings. The
-- "windows key" is usually mod4Mask.
--
myModMask       = mod4Mask
 
-- NOTE: from 0.9.1 on numlock mask is set automatically. The numlockMask
-- setting should be removed from configs.
--
-- You can safely remove this even on earlier xmonad versions unless you
-- need to set it to something other than the default mod2Mask, (e.g. OSX).
--
-- The mask for the numlock key. Numlock status is "masked" from the
-- current modifier status, so the keybindings will work with numlock on or
-- off. You may need to change this on some systems.
--
-- You can find the numlock modifier by running "xmodmap" and looking for a
-- modifier with Num_Lock bound to it:
--
-- > $ xmodmap | grep Num
-- > mod2        Num_Lock (0x4d)
--
-- Set numlockMask = 0 if you don't have a numlock key, or want to treat
-- numlock status separately.
--
-- myNumlockMask   = mod2Mask -- deprecated in xmonad-0.9.1
------------------------------------------------------------
 
 
-- The default number of workspaces (virtual screens) and their names.
-- By default we use numeric strings, but any string may be used as a
-- workspace name. The number of workspaces is determined by the length
-- of this list.
--
-- A tagging example:
--
-- > workspaces = ["web", "irc", "code" ] ++ map show [4..9]
--
myWorkspaces    = ["1","2","3","4","5","6","7:media","8:web","9:notif"]

------------------------------------------------------------------------
-- Key bindings. Add, modify or remove key bindings here.
--
myKeys conf@(XConfig {XMonad.modMask = modm}) = M.fromList $
    [
    -- application a - p
      ((modm,               xK_a     ), spawn web1 )
    , ((modm,               xK_z     ), spawn web2 )
    , ((modm,               xK_e     ), spawn web3 )
    , ((modm,               xK_r     ), spawn editeur )
    , ((modm,               xK_p     ), spawn "exe=`dmenu_path | dmenu -b` && eval \"exec $exe\"")
    -- q m
    , ((modm,               xK_q     ), spawn calculatrice)
    , ((modm,               xK_s     ), spawn $ XMonad.terminal conf)
    , ((modm,               xK_d     ), spawn navigateur_fichier)
    -- w n
    , ((modm,               xK_v     ), spawn volume_mute)
    , ((modm,               xK_b     ), spawn volume_less)
    , ((modm,               xK_n     ), spawn volume_more)
    -- aide
    , ((modm,               xK_F1    ), spawn $ "~/.xmonad/bin/aide.sh xmonad.aide")
    , ((modm,               xK_F2    ), spawn $ "~/.xmonad/bin/aide.sh terminator.aide")
    , ((modm,               xK_F3    ), spawn $ "~/.xmonad/bin/aide.sh vim.aide")
    , ((modm,               xK_F4    ), spawn $ "~/.xmonad/bin/aide.sh git.aide")
    , ((modm,               xK_F5    ), spawn $ "~/.xmonad/bin/aide.sh .aide")
    , ((modm,               xK_F6    ), spawn $ "~/.xmonad/bin/aide.sh .aide")
    , ((modm,               xK_F7    ), spawn $ "~/.xmonad/bin/aide.sh .aide")
    , ((modm,               xK_F8    ), spawn $ "~/.xmonad/bin/aide.sh .aide")
    , ((modm,               xK_F9    ), spawn $ "~/.xmonad/bin/aide.sh .aide")

    -- close focused window
    , ((modm,               xK_c     ), kill)
 
     -- Rotate through the available layout algorithms
    , ((modm,               xK_space ), sendMessage NextLayout)
 
    --  Reset the layouts on the current workspace to default
    , ((modm .|. shiftMask, xK_space ), setLayout $ XMonad.layoutHook conf)
 
    -- Resize viewed windows to the correct size
    , ((modm,               xK_m     ), refresh)
 
    -- Move focus to the next window
    , ((modm,               xK_Tab   ), windows W.focusDown)
 
    -- Move focus to the next window
    , ((modm,               xK_j     ), windows W.focusDown)
 
    -- Move focus to the previous window
    , ((modm,               xK_k     ), windows W.focusUp  )
 
 
    -- Swap the focused window and the master window
    , ((modm,               xK_Return), windows W.swapMaster)
 
    -- Swap the focused window with the next window
    , ((modm .|. shiftMask, xK_j     ), windows W.swapDown  )
 
    -- Swap the focused window with the previous window
    , ((modm .|. shiftMask, xK_k     ), windows W.swapUp    )
 
    -- Shrink the master area
    , ((modm,               xK_h     ), sendMessage Shrink)
 
    -- Expand the master area
    , ((modm,               xK_l     ), sendMessage Expand)
 
    -- Push window back into tiling
    , ((modm,               xK_t     ), withFocused $ windows . W.sink)
 
    -- Increment the number of windows in the master area
    , ((modm              , xK_comma ), sendMessage (IncMasterN 1))
 
    -- Deincrement the number of windows in the master area
    , ((modm              , xK_period), sendMessage (IncMasterN (-1)))
 
    -- Toggle the status bar gap
    -- Use this binding with avoidStruts from Hooks.ManageDocks.
    -- See also the statusBar function from Hooks.DynamicLog.
    --
    , ((modm              , xK_u     ), sendMessage ToggleStruts)
 
    -- raccourcit layout 
    , ((modm .|.  shiftMask,  xK_a   ), sendMessage $ JumpToLayout "Tabbed")
    , ((modm .|.  shiftMask,  xK_z   ), sendMessage $ JumpToLayout "Accordion")
    , ((modm .|.  shiftMask,  xK_e   ), sendMessage $ JumpToLayout "Full")
    , ((modm .|.  shiftMask,  xK_q   ), sendMessage $ JumpToLayout "Tall")
    , ((modm .|.  shiftMask,  xK_s   ), sendMessage $ JumpToLayout "Mirror")
    , ((modm .|.  shiftMask,  xK_d   ), sendMessage $ JumpToLayout "Mosaic")
    , ((modm .|.  shiftMask,  xK_f   ), sendMessage $ JumpToLayout "Taller")
    , ((modm .|.  shiftMask,  xK_g   ), sendMessage $ JumpToLayout "Wider")
    , ((modm .|.  shiftMask,  xK_h   ), sendMessage $ JumpToLayout "Reset")
    -- Quit xmonad
--    , ((modm .|. shiftMask, xK_i     ), io (exitWith ExitSuccess))
 
    -- Restart xmonad
    , ((modm              , xK_o     ), spawn "xmonad --recompile; xmonad --restart")
   ]
    ++
	-- deplacement vers workspace
	[((m .|. modm, k), windows $ f i)
        | (i, k) <- zip (workspaces conf) 	[0x26,0xe9,0x22,0x27,0x28,0x2d,0xe8,0x5f,0xe7,0xe0],
          (f, m) <- [(W.greedyView, 0), (W.shift, shiftMask)]]
    ++
    -- deplacement ecrans
    [((m .|. modm, key), screenWorkspace sc >>= flip whenJust (windows . f))
       | (key, sc) <- zip [xK_w, xK_x, xK_less] [0..]
                 , (f, m) <- [(W.view, 0), (W.shift, shiftMask)]]
 
------------------------------------------------------------------------
-- Mouse bindings: default actions bound to mouse events
--
myMouseBindings (XConfig {XMonad.modMask = modm}) = M.fromList $
 
    -- mod-button1, Set the window to floating mode and move by dragging
    [ ((modm, button1), (\w -> focus w >> mouseMoveWindow w
                                       >> windows W.shiftMaster))
 
    -- mod-button2, Raise the window to the top of the stack
    , ((modm, button2), (\w -> focus w >> windows W.shiftMaster))
 
    -- mod-button3, Set the window to floating mode and resize by dragging
    , ((modm, button3), (\w -> focus w >> mouseResizeWindow w
                                       >> windows W.shiftMaster))
 
    -- you may also bind events to the mouse scroll wheel (button4 and button5)
    ]
 
------------------------------------------------------------------------
-- Layouts:
 
-- You can specify and transform your layouts by modifying these values.
-- If you change layout bindings be sure to use 'mod-shift-space' after
-- restarting (with 'mod-q') to reset your layout state to the new
-- defaults, as xmonad preserves your old layout settings by default.
--
-- * NOTE: XMonad.Hooks.EwmhDesktops users must remove the obsolete
-- ewmhDesktopsLayout modifier from layoutHook. It no longer exists.
-- Instead use the 'ewmh' function from that module to modify your
-- defaultConfig as a whole. (See also logHook, handleEventHook, and
-- startupHook ewmh notes.)
--
-- The available layouts.  Note that each layout is separated by |||,
-- which denotes layout choice.
--
myLayout =  named "Tall" (Tall 1 (3/100) (1/2)) |||  named "Mirror" ( Mirror ( Tall 1 (3/100) (1/2) ))  |||  Full   |||  Accordion  |||  named "Tabbed" ( tabbed shrinkText tabConfig ) |||  named "Mosaic" ( mosaic 2 [3,2] ) 

-- Colors for text and backgrounds of each tab when in "Tabbed" layout.
tabConfig = defaultTheme {
    activeBorderColor = "#1014e0",
    activeTextColor = "#F5F37A",
    activeColor = "#1014e0",
    inactiveBorderColor = "#7C7C7C",
    inactiveTextColor = "#F5F37A",
    inactiveColor = "#a9abf9"
}
------------------------------------------------------------------------
-- Window rules:
 
-- Execute arbitrary actions and WindowSet manipulations when managing
-- a new window. You can use this to, for example, always float a
-- particular program, or have a client always appear on a particular
-- workspace.
--
-- To find the property name associated with a program, use
-- > xprop | grep WM_CLASS
-- and click on the client you're interested in.
--
-- To match on the WM_NAME, you can use 'title' in the same way that
-- 'className' and 'resource' are used below.
--
myManageHook = composeAll
    [ className =? "Vlc"      	   --> doShift "7:media"
    , className =? "Audacious" 	   --> doShift "7:media"
    , className =? "Iceweasel"     --> doShift "8:web"
    , className =? "Transmission-gtk"  --> doShift "9:notif"
    , className =? "Wicd-client.py"  --> doShift "9:notif"
    , className =? "Osmo"  	         --> doShift "9:notif"
    , className =? "Gcalctool"     --> doFloat
    , className =? "Gimp"          --> doFloat
    , className =? "MPlayer"       --> doFloat
    , resource  =? "desktop_window"--> doIgnore
    , isFullscreen --> (doF W.focusDown <+> doFullFloat)
    ]
------------------------------------------------------------------------
-- Event handling
 
-- Defines a custom handler function for X Events. The function should
-- return (All True) if the default handler is to be run afterwards. To
-- combine event hooks use mappend or mconcat from Data.Monoid.
--
-- * NOTE: EwmhDesktops users should use the 'ewmh' function from
-- XMonad.Hooks.EwmhDesktops to modify their defaultConfig as a whole.
-- It will add EWMH event handling to your custom event hooks by
-- combining them with ewmhDesktopsEventHook.
--
myEventHook = mempty
 
------------------------------------------------------------------------
-- Status bars and logging
 
-- Perform an arbitrary action on each internal state change or X event.
-- See the 'XMonad.Hooks.DynamicLog' extension for examples.
--
--
-- * NOTE: EwmhDesktops users should use the 'ewmh' function from
-- XMonad.Hooks.EwmhDesktops to modify their defaultConfig as a whole.
-- It will add EWMH logHook actions to your custom log hook by
-- combining it with ewmhDesktopsLogHook.
--
myLogHook = return ()

-- Command to launch the bar.
myBar = "xmobar"

-- Custom PP, configure it as you like. It determines what is being written to the bar.
myPP = xmobarPP { ppCurrent = xmobarColor xmobarCurrentWorkspaceColor "" . wrap "<" ">",
		ppTitle = xmobarColor xmobarTitleColor "" . shorten 100 }

-- pour le binding faisant disparaitre xmobar
toggleStrutsKey XConfig {XMonad.modMask = modMask} = (modMask, xK_u)

------------------------------------------------------------------------
-- Startup hook
 
-- Perform an arbitrary action each time xmonad starts or is restarted
-- with mod-q.  Used by, e.g., XMonad.Layout.PerWorkspace to initialize
-- per-workspace layout choices.
--
-- By default, do nothing.
--
-- * NOTE: EwmhDesktops users should use the 'ewmh' function from
-- XMonad.Hooks.EwmhDesktops to modify their defaultConfig as a whole.
-- It will add initialization of EWMH support to your custom startup
-- hook by combining it with ewmhDesktopsStartup.
--
myStartupHook = do
        runOrRaise "osmo" (className =? "Osmo")
        runOrRaise "wicd-gtk -n" (className =? "Wicd-client.py")
        spawn "feh --bg-scale ~/.xmonad/wallpapers/black_floral_wallpaper.jpg" 
 
------------------------------------------------------------------------
-- Now run xmonad with all the defaults we set up.
 
-- Run xmonad with the settings you specify. No need to modify this.
--

main = xmonad =<< statusBar myBar myPP toggleStrutsKey defaults 

-- A structure containing your configuration settings, overriding
-- fields in the default config. Any you don't override, will
-- use the defaults defined in xmonad/XMonad/Config.hs
--
-- No need to modify this.
--
defaults = defaultConfig {
      -- simple stuff
        terminal           = myTerminal,
        focusFollowsMouse  = myFocusFollowsMouse,
        borderWidth        = myBorderWidth,
        modMask            = myModMask,
        -- numlockMask deprecated in 0.9.1
        -- numlockMask        = myNumlockMask,
        workspaces         = myWorkspaces,
        normalBorderColor  = myNormalBorderColor,
        focusedBorderColor = myFocusedBorderColor,
 
      -- key bindings
        keys               = myKeys,
        mouseBindings      = myMouseBindings,
 
      -- hooks, layouts
        layoutHook         = myLayout,
        manageHook         = myManageHook,
        handleEventHook    = myEventHook,
        logHook            = myLogHook,
        startupHook        = myStartupHook
    }
