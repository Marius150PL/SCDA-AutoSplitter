/***************************************************************************************\
* Tom Clancy's Splinter Cell: Double Agent (PC) AutoSplitter.                           *
* By Distro and Marius150PL.                                                            *
* This current version is for testing purposes only.                                    *
* We hope it'll works for everyone.                                                     *
* AutoSplitter remembers your visited maps, so it doesn't split on played or unchecked  *
* maps in settings even when game crashes (so don't reset timer, unless you want        *
* restart your run).                                                                    *
* To properly work you will need to have exactly as many splits, as checked boxes for   *
* maps (except for Iceland). Major levels are selected by default.                      *
* - If you check Iceland, timer starts when level is loaded.                            *
* - If you check Coast Guard Boat, timer will stop on To Be Continued screen in this    *
*   map, instead JBA HQ after defusing bomb. Check it if you doing Best Ending run.     *
* - If you check other levels, then timer will split after loading these levels.        *
* Please leave some feedback on how well the AutoSplitter works and report bugs to us.  *
* ____________________________________|HOW TO ADD?|____________________________________ *
* For Loading Removal to work you need to set all Livesplit time settings to Game Time. *
* Those settings are:                                                                   *
* 1.In Main Layout - Right Click - "Compare Against -> Game Time",                      *
* 2.In Main Layout - Right Click - "Edit Layout" - "Layout Settings" - "Splits" tab -   *
* set all "Timing Method" settings to "Game Time" do the same in "Timer" tab.           *
\***************************************************************************************/

state("splintercell4"){	
    // Loading Removal
    bool isLoading: "Engine.dll", 0x22D590, 0x0;
    bool isSaving: "Engine.dll", 0xE7E4B0, 0x4;
    bool isSL: "Engine.dll", 0x58A2F8, 0x0;
    int videoLoading: "SplinterCell4.exe", 0x18BE0, 0x468;
    int staticLoading: "Engine.dll", 0x2300C4, 0x0;

    // Maps
	string32 map: "DareDSound3D_scr_rd.dll", 0x29300, 0x8C;

    // Iceland
    int cutscene0: "EchelonMenus.DLL", 0xA3B54, 0x758;
    int cutscene1: "Engine.dll", 0xA16E38, 0xA40;

    // JBA HQ4 Part 2
    short defused: "Engine.dll", 0xE78860, 0x78, 0x1C, 0x20, 0x7C, 0xE0, 0x538, 0xEEC;

    // Coast Guard Boat
    int missionComplete0: "EchelonMenus.DLL", 0xA3CF4, 0xC, 0x118, 0x44, 0x0, 0x4;
    int missionComplete1: "EchelonMenus.DLL", 0xA3D30, 0x14, 0x8, 0x248, 0x38, 0x0, 0x4;
}

startup{
    settings.Add("01_intro", false, "Iceland - Geothermal Plant - default off.");
	settings.Add("02_Jail_01", true, "Kansas - Ellsworth Penitentiary");
	settings.Add("00_HQ_01_A", true, "NYC - JBA HQ - Part 1");
	settings.Add("03_Okhotsk_01", true, "Sea of Okhotsk");
	settings.Add("03_Okhotsk_02", false, "Sea of Okhotsk - Part 2");
    settings.Add("04_hotel", true, "Shanghai - Hotel");
	settings.Add("00_HQ_03_A", true, "NYC - JBA HQ - Part 2");
	settings.Add("05_Cozumel_01", true, "Cozumel - Cruise Ship");
	settings.Add("05_Cozumel_02", false, "Cozumel - Cruise Ship - Part 2");
	settings.Add("00_HQ_04", true, "NYC - JBA HQ - Part 3");
	settings.Add("07_Kinshasa00", true, "Kinshasa");
	settings.Add("07_Kinshasa01", false, "Kinshasa - Part 2");
	settings.Add("07_Kinshasa02", false, "Kinshasa - Part 3");
	settings.Add("00_HQ_05", true, "NYC - JBA HQ - Part 4");
	settings.Add("00_HQ_05_B", false, "NYC - JBA HQ - Final Confrontation");
	settings.Add("10_newyork_02", false, "NYC - Coast Guard Boat - check it if you do Best Ending run.");
    vars.visited = new List<String>();
}

isLoading{
    return (current.isLoading || current.isSaving || current.isSL || current.videoLoading != 0 || current.staticLoading != 0 || current.map == "menu");
}

start{
    if(current.map == "01_intro"){
        if(!settings[current.map]){
            if((current.cutscene0 == 22 && old.cutscene0 == 1558) || (current.cutscene1 > 0 && old.cutscene1 == 0)){
                return true;
            }
        }
        else{
            if(current.videoLoading == 0 && current.staticLoading == 0){
                return true;
            }
        }
    }
}

onStart{
    vars.visited.Add(current.map);
}


split{
    if(current.map == old.map){
        if(settings[current.map] && !vars.visited.Contains(current.map)){
			vars.visited.Add(current.map);
			return true;
		}
    }

    if(!settings["10_newyork_02"] && current.map == "00_HQ_05_B" && current.defused == 257 && old.defused == 256){
        return true;
    }

    if(settings["10_newyork_02"] && current.map == "10_newyork_02" && current.missionComplete0 == 306 && current.missionComplete1 == 19){
        return true;
    }
}

onReset{
    vars.visited.Clear();
}