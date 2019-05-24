*******************************************************
	"Submarine Accident" v1.0 static mission for Altis.
	Created by Cloudskipper using templates by eraser1
	Reinforcements of AI vehicle patrols, 2 different groups of AI so one is dedicated sniper
	This version includes AI heli - thanks to aussie battler for help with this
	Diffficulty of mission not linked to difficulty of AI if you want.
	easy/mod/difficult/hardcore - reworked by [CiC]red_ned http://cic-gaming.co.uk
*******************************************************
	For Altis only.
	Running on DMS System
*******************************************************


Installing.
1. 	Copy gogs_submarine_accident.sqf into a3_dms.pbo missions/static
2. 	Copy gogs_submarine_buildings.sqf into a3_dms.pbo objects/static

>>>>>>>>Either<<<<<<<<<<<
3. 	Extract  map_configs/altis_config.sqf
4.	Add to end

// Add the "gogs_submarine_accident" mission to the existing mission types.
DMS_StaticMissionTypes append 
[["gogs_submarine_accident",1]];
*******************************************************
DO NOT ADD THE BUILDINGS - they are called on mission spawn.
*******************************************************
5.	Repack altis_config.sqf	into PBO

>>>>>>>>OR<<<<<<<<<<<<<<
Edit main DMS config.sqf
6.	Find
	DMS_StaticMissionTypes =			[							// List of STATIC missions with spawn chances.
											//["saltflats",1],		//<--Example (already imported by default on Altis)
											//["slums",1]			//<--Example (already imported by default on Altis)
										];

	DMS_BasesToImportOnServerStart = 	[							// List of static bases to import on server startup (spawned post-init). This will reduce the amount of work the server has to do when it actually spawns static missions, and players won't be surprised when a base suddenly pops up. You can also include any other M3E-exported bases to spawn here.
											//"saltflatsbase",		//<--Example (already imported by default on Altis)
											//"slums_objects"		//<--Example (already imported by default on Altis)
											// DO NOT ADD THE BUILDINGS - they are called on mission spawn.
										];
replace with

	DMS_StaticMissionTypes =			[
											["gogs_submarine_accident",1]
										];

	DMS_BasesToImportOnServerStart = 	[
											// DO NOT ADD THE BUILDINGS - they are called on mission spawn.
										];
										
7. Save and repack config into PBO

8. 	Put a3_dms.pbo into /@ExileServer/addons/ on server and start.