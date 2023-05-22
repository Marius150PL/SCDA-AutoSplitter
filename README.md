# Splinter Cell: Double Agent AutoSplitter

### Autosplitter for [LiveSplit](https://github.com/LiveSplit/LiveSplit/releases) of Splinter Cell: Double Agent (PC).

AutoSplitter remembers your visited maps, so it doesn't split on played or unchecked maps in settings even when game crashes (so don't reset timer, unless you want restart your run).

To properly work you will need to have exactly as many splits, as checked boxes for maps (except for Iceland). Major levels are selected by default.
  - If you check Iceland, timer starts when level is loaded.
  - If you check Coast Guard Boat, timer will stop on To Be Continued screen in this map, instead JBA HQ after defusing bomb. Check it if you doing Best Ending run.
- If you check other levels, then timer will split after loading these levels.

## How to add?
For Loading Removal to work you need to set all Livesplit time settings to Game Time.
Those settings are:

1. In Main Layout - Right Click - "Compare Against -> Game Time",
2. In Main Layout - Right Click - "Edit Layout" - "Layout Settings" - "Splits" tab - set all "Timing Method" settings to "Game Time" do the same in "Timer" tab.

### Please leave some feedback on how well the AutoSplitter works and report bugs to us.

## Memory addresses

| Name | Type | Module | OS0 | OS1 | More OSs? | Description |
|---|---|---|---|---|---|---|
| isLoading | bool | Engine.dll | 0x22D590 | 0x0 | No | `true` on loading in game. |
| isSaving | bool | Engine.dll | 0xE7E4B0 | 0x4 | No | `true` on saving in game. |
| isSL | bool | Engine.dll | 0x58A2F8 | 0x0 | No | `true` on saving and loading in game. |
| videoLoading | int | SplinterCell4.exe | 0x18BE0 | 0x468 | No | `707` during level loadings or loading to main menu. `0` otherwise. |
| staticLoading | int | Engine.dll | 0x2300C4 | 0x0 | No | `0` in gameplay. `1` during static loading screen. `256` in main menu and video loadings from it. `257` after video loading and before static loading. `0` and `1` values are even for very short time when finish transition to main menu. |
| map | string32 | DareDSound3D_scr_rd.dll | 0x29300 | 0x8C | No | Level name as String. |
| cutscene0 | int | EchelonMenus.DLL | 0xA3B54 | 0x758 | No | `1558` on cinematic cutscene or `1046` in like Shanghai's end cutscene, `22` in game or cutscene like Prison's beginning cutscene. Other values might be in other cases. |
| cutscene1 | int | Engine.dll | 0xA16E38 | 0xA40 | No | `0` on cinematic cutscene and for short time in isLoading. `1065353216` in game. Other values might be in other cases. |
| defused0 | short | Engine.dll | 0xE78860 | 0x78 | Yes | `256` when bomb not defused, `257` when defused. For short time in first loading sets to `257`. |
| defused1 | int | Engine.dll | 0xE80C58 | 0x864 | Yes | `1073742080` when bomb not defused, `...81` when defused. For short time in first loading sets to `...81`. |
| missionComplete0 | int | EchelonMenus.DLL | 0xA3CF4 | 0xC | Yes | `291` in gameplay, `306` when Mission Complete or TBC screen appears and keeps to end of video loadings to next level. Also sets to `306` when using computer. |
| missionComplete1 | int | EchelonMenus.DLL | 0xA3D30 | 0x14 | Yes | `17` in gameplay, `19` when Mission Complete or TBC screen appears and keeps to end of video loadings to next level. Also sets to `19` when using computer. |