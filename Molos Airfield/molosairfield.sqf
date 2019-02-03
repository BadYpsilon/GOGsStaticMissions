/*
	"Molos Airfield" static mission for Altis.
	Created by Cloudskipper for GOG´s
	based on work by Defent and eraser1
*/

// For logging purposes
_num = DMS_MissionCount;


// Set mission side (only "bandit" is supported for now)
_side = "bandit";

// Mission Center, the Airport Tower
_pos = 	[26824.557,24575.25,0];

if ([_pos,DMS_StaticMinPlayerDistance] call DMS_fnc_IsPlayerNearby) exitWith {"delay"};


// Set general mission difficulty
_difficulty = "hardcore";

// Define spawn locations for AI Soldiers. These will be used for the initial spawning of AI as well as reinforcements.
_AISoldierSpawnLocations =
[
	[26762.1,24650.1,0.65],		// Inside Hangar
	[26755.8,24647.9,0.65],		// Inside Hangar
	[26757.6,24653.9,0.65],		// Inside Hangar
	[26762.9,24657.9,0.65],		// Inside Hangar
	[26761.5,24644.2,0.65],		// Inside Hangar
	[26766.1,24646.4,0.65],		// Inside Hangar
	[26766.8,24652.6,0.65],		// Inside Hangar
	[26903.3,24551.5,0.5], 		// Inside Industial Shed
	[26898.2,24550.1,0.5], 		// Inside Industial Shed
	[26898.3,24545.4,0.5], 		// Inside Industial Shed
	[26844.17,24485.9,17.73], 	// Tower #1 on Top
	[26851.81,24490.1,17.79], 	// Tower #1 on Top
	[26845.11,24494.72,15.55], 	// Tower #1 Second Level
	[26850.51,24493.61,15.41], 	// Tower #1 Second Level
	[26843.51,24491.71,12.88], 	// Tower #1 First Level
	[26848.41,24487.63,12.63], 	// Tower #1 First Level
	[27029.31,24696.76,18.05], 	// Tower #2 on Top
	[27038.44,24692.65,17.77], 	// Tower #2 on Top
	[27032.65,24692.89,15.34], 	// Tower #2 Second Level
	[27036.25,24698.38,15.35], 	// Tower #2 Second Level
	[27037.37,24695.03,12.67], 	// Tower #2 First Level
	[27031.61,24697.39,12.84] 	// Tower #2 First Level
];

// Create Assault AI
_AICount = 30 + (round (random 16));


// Spawn the AI´s
_group =
[
	_AISoldierSpawnLocations,
	_AICount,
	_difficulty,
	"assault",
	_side
] call DMS_fnc_SpawnAIGroup_MultiPos;



// Spawn the static HMG´s
_staticGuns =
[
	[
	[26843.95,24488.979,17.905], 	// Tower #1 on Top
	[26843.44,24488.512,15.375], 	// Tower #1 Second Level
	[26844.15,24495.44,13.245], 	// Tower #1 First Level
	[27031.129,24693.305,17.89], 	// Tower #2 on Top
	[27029.084,24690.275,15.55], 	// Tower #2 Second Level
	[27037.285,24700.033,12.74], 	// Tower #2 First Level
	[26928.035,24561.262,0.05], 	// Shooting Range
	[26900.42,24555.193,0.510], 	// Inside Industial Shed
	[26896.1,24541.21,0.275], 		// Inside Industial Shed	
	[26824.557,24575.25,12.21], 	// Airport Tower on Top
	[26831.521,24583.176,12.94], 	// Airport Tower Second Level
	[26831.18,24584.027,9.255], 	// Airport Tower First Level
	[26859.775,24619.654,0.05], 	// Between the Containers
	[26859.021,24605.084,0.05], 	// Between the Containers	
	[26855.406,24479.33,0.05], 		// Inside the Shed under Tower #1
	[26696.1,24610.35,0.05], 		// Behinde the Office Building
	[26751.779,24668.75,0.77], 		// Indside Hangar
	[26740.986,24654.79,0.47], 		// Indside Hangar	
	[26838.29,24674.1,3.77], 		// Inside Barracks
	[26876.82,24692.3,3.78], 		// Inside Barracks	
	[26981.15,24757.895,2.75], 		// Inside Tower Bunker
	[27034.15,24713.85,2.75], 		// Inside Tower Bunker
	[26756.23,24552.5,2.3], 		// Inside H-Barrier Watchtower (Entrance)
	[26731.7,24573.8,2.3], 			// Inside H-Barrier Watchtower (Entrance)
	[26730.1,24653.16,2.3], 		// Inside H-Barrier Watchtower (Hangar)
	[26753.8,24678.9,2.3] 			// Inside H-Barrier Watchtower (Hangar)
	],
	_group,
	"assault",
	_difficulty,
	_side,
	"random"
] call DMS_fnc_SpawnAIStaticMG;


// Spawn the vehicle AFTER the base so that it spawns the vehicle in a (relatively) clear position.
_veh =
[
	[
		[26731.1,24628,0.05]
	],
	_group,
	"assault",
	_difficulty,
	_side
] call DMS_fnc_SpawnAIVehicle;

// Spawn the vehicle AFTER the base so that it spawns the vehicle in a (relatively) clear position.
// Hunter HMG
_veh2 =
[
	[
		[26777.1,24682.3,0.05]
	],
	_group,
	"assault",
	_difficulty,
	_side,
	"B_MRAP_01_hmg_F"
] call DMS_fnc_SpawnAIVehicle;

// Spawn the vehicle AFTER the base so that it spawns the vehicle in a (relatively) clear position.
// Spawns a Ghosthawk
_veh3 =
[
	[
		[26867.4,24504.6,0.05]
	],
	_group,
	"MG",
	_difficulty,
	_side,
	"B_Heli_Transport_01_F"
] call DMS_fnc_SpawnAIVehicle;



// Define the classnames and locations where the crates can spawn (at least 2, since we're spawning 2 crates)
_crateClasses_and_Positions =
[
	[[26747.2,24654.8,0.5],"I_CargoNet_01_ammo_F"],
	[[26754.1,24662,0.5],"I_CargoNet_01_ammo_F"]
];

{
	deleteVehicle (nearestObject _x);		// Make sure to remove any previous crates.
} forEach _crateClasses_and_Positions;

// Shuffle the list
_crateClasses_and_Positions = _crateClasses_and_Positions call ExileClient_util_array_shuffle;


// Create Crates
_crate0 = [_crateClasses_and_Positions select 0 select 1, _crateClasses_and_Positions select 0 select 0] call DMS_fnc_SpawnCrate;
_crate1 = [_crateClasses_and_Positions select 1 select 1, _crateClasses_and_Positions select 1 select 0] call DMS_fnc_SpawnCrate;


// Define mission-spawned AI Units
_missionAIUnits =

[
	_group		// Assaultgroup
];


// Define the group reinforcements
_groupReinforcementsInfo =
[
	[
		_group,			// pass the group
		[
			[
				2,		// Only 2 "waves" (2 vehicles can spawn as reinforcement)
				0
			],
			[
				-1,		// No need to limit the number of units since we're limiting "waves"
				0
			]
		],
		[
			60,		// At least a 1 minute delay between reinforcements.
			diag_tickTime
		],
		[
				[26777.1,24682.3,0.1],
				[26731.1,24628,0.1]
		],
		"random",
		_difficulty,
		_side,
		"armed_vehicle",
		[
			20,			// Reinforcements will only trigger if there's fewer than 7 members left in the group
			"random"	// Select a random armed vehicle from "DMS_ArmedVehicles"
		]
	],
	[
		_group,			// pass the group (again)
		[
			[
				-1,		// Let's limit number of units instead...
				0
			],
			[
				50,	// Maximum 100 units can be given as reinforcements.
				0
			]
		],
		[
			60,		// About a 1 minute delay between reinforcements.
			diag_tickTime
		],
		_AISoldierSpawnLocations,
		"random",
		_difficulty,
		_side,
		"reinforce",
		[
			10,			// Reinforcements will only trigger if there's fewer than 10 members left in the group
			7			// 7 reinforcement units per wave.
		]
	],
	[
		_group,			// pass the group (again)
		[
			[
				1,		// Let's limit number of units instead...
				0
			],
			[
				5,	// Maximum 5 units can be given as reinforcements.
				0
			]
		],
		[
			60,		// About a 1 minute delay between reinforcements.
			diag_tickTime
		],
		_pos,
		"random",
		_difficulty,
		_side,
		"heli_troopers",
			[
				30,								// SCALAR: If the AI Group has fewer than "_AICount" living units, then the group will receive reinforcements.
		        false,   			            // BOOLEAN: Whether or not to eject Fire-From-Vehicle (FFV) gunners.
		        999,        			        // SCALAR: Maximum number of AI to eject from the aircraft. Set to a really high # to ignore (like 999).
		        true,             				// BOOLEAN: Whether or not to keep the heli flying around as a gunship.
				_pos,							// OBJECT or ARRAY (OPTIONAL - Position2D or 3D): The location to drop the reinforcements at. The drop point will default to the group leader.
				"B_Heli_Transport_01_F"			// STRING (OPTIONAL): The classname of the heli to spawn.
				
			]
	]
];






// Define mission-spawned objects and loot values
_missionObjs =
[
	_staticGuns+[_veh]+[_veh2]+[_veh3],			// armed AI vehicle and static gun(s). Note, we don't add the base itself because we don't want to delete it and respawn it if the mission respawns.
	[],
	[[_crate0,[50,100,2]],[_crate1,[3,150,15]]]
];

// Define Mission Start message
_msgStart = ['#FFFF00',"The rebels try to escape from their airbase, stop them and secure the Loot...Bring your friends, you will need them"];

// Define Mission Win message
_msgWIN = ['#0080ff',"Convicts have successfully assaulted the base and secured the cache!"];

// Define Mission Lose message
_msgLOSE = ['#FF0000',"The Rebels were able to load their airplanes and are now on their way to Tanoa."];

// Define mission name (for map marker and logging)
_missionName = "Molos Airfield";

// Create Markers
_markers =
[
	_pos,
	_missionName,
	_difficulty
] call DMS_fnc_CreateMarker;

(_markers select 1) setMarkerSize [750,750];

// Record time here (for logging purposes, otherwise you could just put "diag_tickTime" into the "DMS_AddMissionToMonitor" parameters directly)
_time = diag_tickTime;

// Parse and add mission info to missions monitor
_added =
[
	_pos,
	[
		[
			"kill",
			_group
		],
		[
			"playerNear",
			[_pos,100]
		]
	],
	_groupReinforcementsInfo,
	[
		_time,
		DMS_StaticMissionTimeOut call DMS_fnc_SelectRandomVal
	],
	_missionAIUnits,
	_missionObjs,
	[_missionName,_msgWIN,_msgLOSE],
	_markers,
	_side,
	_difficulty,
	[]
] call DMS_fnc_AddMissionToMonitor_Static;

// Check to see if it was added correctly, otherwise delete the stuff
if !(_added) exitWith
{
	diag_log format ["DMS ERROR :: Attempt to set up mission %1 with invalid parameters for DMS_fnc_AddMissionToMonitor_Static! Deleting mission objects and resetting DMS_MissionCount.",_missionName];

	_cleanup = [];
	{
		_cleanup pushBack _x;
	} forEach _missionAIUnits;

	_cleanup pushBack ((_missionObjs select 0)+(_missionObjs select 1));

	{
		_cleanup pushBack (_x select 0);
	} foreach (_missionObjs select 2);

	_cleanup call DMS_fnc_CleanUp;


	// Delete the markers directly
	{deleteMarker _x;} forEach _markers;


	// Reset the mission count
	DMS_MissionCount = DMS_MissionCount - 1;
};


// Notify players
[_missionName,_msgStart] call DMS_fnc_BroadcastMissionStatus;



if (DMS_DEBUG) then
{
	(format ["MISSION: (%1) :: Mission #%2 started at %3 with %4 AI units and %5 difficulty at time %6",_missionName,_num,_pos,_AICount,_difficulty,_time]) call DMS_fnc_DebugLog;
};




