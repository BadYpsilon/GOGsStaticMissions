/*
	"Marine Base" static mission for Altis.
	Created by Cloudskipper for GOG´s
*/

// For logging purposes
_num = DMS_MissionCount;


// Set mission side (only "bandit" is supported for now)
_side = "bandit";

// Mission Center, in front of the big Tower
_pos = 	[14283.82,13030.254,0];

if ([_pos,DMS_StaticMinPlayerDistance] call DMS_fnc_IsPlayerNearby) exitWith {"delay"};


// Set general mission difficulty
_difficulty = "hardcore";


// Define spawn locations for AI Soldiers. These will be used for the initial spawning of AI as well as reinforcements.
// The center spawn location is added 3 times so at least 3 AI will spawn initially at the center location, and so that future reinforcements are more likely to spawn at the center.
_AISoldierSpawnLocations =
[
	[14226.9,13024.3,0.05],
	[14229.2,13035.5,0.05],
	[14249.6,13064.8,0.05],
	[14246.6,13064.1,0.05],
	[14261.5,13019,0.05],
	[14251.3,13017.8,0.05],
	[14322.3,13048.2,0.05],
	[14322.4,13040.1,0.05],
	[14282.9,13025.7,0.05],
	[14277.3,13024.5,0.05],
	[14017.1,12979.5,0.05],
	[14017.7,12985.9,0.05],
	[14362.5,13051.7,0.05],
	[14179.3,12926.2,0.05],
	[14168.9,13016.6,0.05]
];

_AISniperSpawnLocations =
[
	[14182.1,12931.3,0.05],
	[14170.4,13020.2,0.05],
	[14169.8,13021.6,0.05],
	[14037.6,12955.1,0.05],
	[14363.4,13047.1,0.05],
	[14044.4,13009.2,0.05],
	[14179.3,12932.9,0.05]
];


_AIReinforcementsSpawnLocations = 
[
	[14030,12952,0],
	[14033.2,12954.4,0],
	[14030.1,12956.9,0],
	[14025.8,13013.3,0],
	[14024.6,13011.4,0],
	[14029.2,13010.5,0],
	[14189.2,12914.8,0],
	[14186.4,12916.2,0],
	[14188.8,12917.8,0]
];

// Antisniper Reinforcements Big Island
_AIBigIslandSpawnLocations = 
[
	[14291.5,13476.5,0],
	[14262.8,13489,0],
	[14251.4,13482.3,0],
	[14273.9,13463.9,01]
];

// Antisniper Reinforcements Little Island
_AISmallIslandSpawnLocations = 
[
	[13621.6,12225.7,0],
	[13610.8,12232.2,0],
	[13615.3,12225.7,0],
	[13621.9,12232.6,0]
];

// Create Assault AI
_AICount = 10 + (round (random 10));

// Create Sniper AI
_AICountSnipers = 10 + (round (random 5));

_group =
[
	_AISoldierSpawnLocations,
	_AICount,
	_difficulty,
	"assault",
	_side
] call DMS_fnc_SpawnAIGroup_MultiPos;

_group2 =
[
	_AISniperSpawnLocations,
	_AICountSnipers,
	_difficulty,
	"sniper",
	_side
] call DMS_fnc_SpawnAIGroup_MultiPos;


_staticGuns =
[
	[
	[14261.3,13008.1,4.3], // Inside the small Tower
	[14242.3,13008.3,4.3], // Inside the small Tower
	[14010.5,12971.6,4.3], // Inside the small Tower
	[14292.6,13025.4,18], // on top of the Tower
	[14300.5,13029.5,18], // on top of the Tower
	[14292.3,13035,18], // on top of the Tower
	[14337.4,13045.8,4], // on top of the Bunker
	[14288.9,13457.8,7], // on the Island
	[14300.6,13030.3,0],
	[14333.6,13028.2,0],
	[14332.9,13055,0],
	[14272.2,13006.4,0],
	[14289.2,13068.1,0]
	],
	_group,
	"assault",
	_difficulty,
	"bandit",
	"random"
] call DMS_fnc_SpawnAIStaticMG;



// Create Crate
_crateClassname = "I_CargoNet_01_ammo_F";
deleteVehicle (nearestObject [_pos, _crateClassname]);		// Make sure to remove any previous crate.

_crate = [_crateClassname, _pos] call DMS_fnc_SpawnCrate;



// Spawn the vehicle AFTER the base so that it spawns the vehicle in a (relatively) clear position.
_veh =
[
	[
		[14090.4,12977.2,0.1]
	],
	_group,
	"assault",
	_difficulty,
	_side
] call DMS_fnc_SpawnAIVehicle;

// Spawn the vehicle AFTER the base so that it spawns the vehicle in a (relatively) clear position.
// Armed Patrol Boat
_veh2 =
[
	[
		[14225.41,13212.853,0]
	],
	_group,
	"assault",
	_difficulty,
	_side,
	"B_Boat_Armed_01_minigun_F"
] call DMS_fnc_SpawnAIVehicle;

// Spawn the vehicle AFTER the base so that it spawns the vehicle in a (relatively) clear position.
// Spawns a Ghosthawk
_veh3 =
[
	[
		[14218.5,12867.2,0.1]
	],
	_group,
	"MG",
	_difficulty,
	_side,
	"B_Heli_Transport_01_F"
] call DMS_fnc_SpawnAIVehicle;


// Define mission-spawned AI Units
_missionAIUnits =

[
	_group, 	// Assaultgroup
	_group2		// Snipergroup
];

// Define the group reinforcements
_groupReinforcementsInfo =
[
	[
		_group,			// pass the group
		[
			[
				5,		// Only 5 "waves" (5 vehicles can spawn as reinforcement)
				0
			],
			[
				-1,		// No need to limit the number of units since we're limiting "waves"
				0
			]
		],
		[
			300,		// At least a 5 minute delay between reinforcements.
			diag_tickTime
		],
		[
				[14090.4,12977.2,0.05],
				[14233.4,12907.1,0.05],
				[14207.8,13023.6,0.05]
		],
		"random",
		_difficulty,
		_side,
		"armed_vehicle",
		[
			7,			// Reinforcements will only trigger if there's fewer than 7 members left in the group
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
				100,	// Maximum 100 units can be given as reinforcements.
				0
			]
		],
		[
			240,		// About a 4 minute delay between reinforcements.
			diag_tickTime
		],
		_AIReinforcementsSpawnLocations,
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
				5,	// Maximum 100 units can be given as reinforcements.
				0
			]
		],
		[
			60,		// About a 1 minute delay between reinforcements.
			diag_tickTime
		],
		_AIBigIslandSpawnLocations,
		"random",
		_difficulty,
		_side,
		"reinforce",
		[
			20,			// Reinforcements will only trigger if there's fewer than 20 members left in the group
			5			// 5 reinforcement units per wave.
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
				5,	// Maximum 100 units can be given as reinforcements.
				0
			]
		],
		[
			60,		// About a 1 minute delay between reinforcements.
			diag_tickTime
		],
		_AISmallIslandSpawnLocations,
		"random",
		_difficulty,
		_side,
		"reinforce",
		[
			20,			// Reinforcements will only trigger if there's fewer than 20 members left in the group
			5			// 5 reinforcement units per wave.
		]
	]
];

// Define mission-spawned objects and loot values
_missionObjs =
[
	_staticGuns+[_veh]+[_veh2]+[_veh3],			// armed AI vehicle and static gun(s). Note, we don't add the base itself because we don't want to delete it and respawn it if the mission respawns.
	[],
	[[_crate,[75,250,25]]]
];

// Define Mission Start message
_msgStart = ['#FFFF00', "Rebels are rading a IDAB Base, kill them and secure the loot for yourself...Bring your friends, you will need them"];

// Define Mission Win message
_msgWIN = ['#0080ff',"Convicts have successfully assaulted the base and secured the cache!"];

// Define Mission Lose message
_msgLOSE = ['#FF0000',"Seems like the Rebels got bored and left the base, taking the cache with them..."];

// Define mission name (for map marker and logging)
_missionName = "Marine Base";

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
