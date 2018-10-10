/*
	"Molos Siege" v2.1 static mission for Altis.
	Created by Cloudskipper using templates by eraser1
	Exile_Chopper_Huey_Desert increases persistent chance with difficulty
	Reinforcements of AI vehicle patrols, 2 different groups of AI so one is dedicated sniper
	This version includes AI heli - thanks to aussie battler for help with this
	Diffficulty of mission not linked to difficulty of AI if you want.
*/

private ["_AICount", "_AICountSnipers", "_AIMaxReinforcements", "_AItrigger", "_AIwave", "_AIdelay", "_staticguns", "_missionObjs", "_crate0", "_crate1", "_cash0", "_cash1", "_crate_loot_values0", "_crate_loot_values1", "_crate_weapons0", "_crate_weapons1", "_crate_items0", "_crate_items1", "_crate_backpacks0", "_crate_backpacks1", "_difficultyM", "_difficulty", "_PossibleDifficulty", "_msgWIN", "_vehicle", "_pinCode", "_VehicleChance", "_baseObjs", "_AISniperSpawnLocations", "_AIPatrolSpawnLocations", "_group2", "_group3", "_veh", "_Vwin", "_dropPoint", "_heliClass", "_spawnPos"];

// For logging purposes
_num = DMS_MissionCount;

// Set mission side (only "bandit" is supported for now)
_side = "bandit";

// Center of the Mission
_pos = [27046,23255,0]; 

if ([_pos,DMS_StaticMinPlayerDistance] call DMS_fnc_IsPlayerNearby) exitWith {"delay"};

//create possible difficulty add more of one difficulty to weight it towards that
_PossibleDifficulty		= 	[	
								//"easy",
								//"moderate",
								"moderate",
								//"difficult",
								"difficult",
								"difficult",
								"hardcore",
								"hardcore",
								"hardcore",
								"hardcore"
							];
//choose mission difficulty and set value and is also marker colour
_difficultyM = selectRandom _PossibleDifficulty;

switch (_difficultyM) do
{
	case "easy":
	{
		_difficulty = "easy";						//AI difficulty
		_AICount = (15 + (round (random 5)));				//AI starting numbers
		_AICountSnipers = (2 + (round (random 4)));			//Max 20
		_AIMaxReinforcements = (20 + (round (random 30)));		//AI reinforcement cap
		_AItrigger = (10 + (round (random 5)));				//If AI numbers fall below this number then reinforce if any left from AIMax
		_AIwave = (4 + (round (random 2)));				//Max amount of AI in reinforcement wave
		_AIdelay = (55 + (round (random 120)));				//The delay between reinforcements
		_VehicleChance = 25;						//25% SpawnPersistentVehicle chance
		_crate_weapons0 	= (20 + (round (random 25)));		//Crate 0 weapons number
		_crate_items0 		= (5 + (round (random 20)));		//Crate 0 items number
		_crate_backpacks0 	= (3 + (round (random 1)));		//Crate 0 back packs number
		_crate_weapons1 	= (25+ (round (random 20)));		//Crate 1 weapons number
		_crate_items1 		= (10 + (round (random 40)));		//Crate 1 items number
		_crate_backpacks1 	= (1 + (round (random 8)));		//Crate 1 back packs number
		_cash0 = (1000 + round (random (1500)));			//Tabs for crate0
		_cash1 = (1000 + round (random (5000)));			//Tabs for crate1
	};
	case "moderate":
	{
		_difficulty = "moderate";
		_AICount = (15 + (round (random 5)));
		_AICountSnipers = (4 + (round (random 4)));			//Max 20
		_AIMaxReinforcements = (30 + (round (random 30)));
		_AItrigger = (10 + (round (random 10)));
		_AIwave = (5 + (round (random 3)));
		_AIdelay = (55 + (round (random 120)));
		_VehicleChance = 50;						//50% SpawnPersistentVehicle chance
		_crate_weapons0 	= (30 + (round (random 25)));
		_crate_items0 		= (10 + (round (random 15)));
		_crate_backpacks0 	= (3 + (round (random 1)));
		_crate_weapons1 	= (25 + (round (random 30)));
		_crate_items1 		= (20 + (round (random 30)));
		_crate_backpacks1 	= (5 + (round (random 5)));
		_cash0 = (1000 + round (random (1500)));			//Tabs for crate0
		_cash1 = (1000 + round (random (5000)));			//Tabs for crate1
	};
	case "difficult":
	{
		_difficulty = "difficult";
		_AICount = (15 + (round (random 7)));
		_AICountSnipers = (6 + (round (random 6)));			//Max 20
		_AIMaxReinforcements = (40 + (round (random 40)));
		_AItrigger = (10 + (round (random 10)));
		_AIwave = (6 + (round (random 3)));
		_AIdelay = (55 + (round (random 120)));
		_VehicleChance = 75;						//75% SpawnPersistentVehicle chance
		_crate_weapons0 	= (40 + (round (random 25)));
		_crate_items0 		= (15 + (round (random 10)));
		_crate_backpacks0 	= (3 + (round (random 3)));
		_crate_weapons1 	= (25 + (round (random 40)));
		_crate_items1 		= (30 + (round (random 20)));
		_crate_backpacks1 	= (6 + (round (random 6)));
		_cash0 = (1000 + round (random (1500)));			//Tabs for crate0
		_cash1 = (1000 + round (random (5000)));			//Tabs for crate1
	};
	//case "hardcore":
	default
	{
		_difficulty = "hardcore";
		_AICount = (15 + (round (random 10)));
		_AICountSnipers = (10 + (round (random 10)));			//Max 20
		_AIMaxReinforcements = (50 + (round (random 50)));
		_AItrigger = (15 + (round (random 10)));
		_AIwave = (6 + (round (random 4)));
		_AIdelay = (55 + (round (random 120)));
		_VehicleChance = 90;						//90% SpawnPersistentVehicle chance
		_crate_weapons0 	= (50 + (round (random 25)));
		_crate_items0 		= (20 + (round (random 25)));
		_crate_backpacks0 	= (2 + (round (random 5)));
		_crate_weapons1 	= (25 + (round (random 50)));
		_crate_items1 		= (40 + (round (random 25)));
		_crate_backpacks1 	= (10 + (round (random 2)));
		_cash0 = (1000 + round (random (1500)));			//Tabs for crate0
		_cash1 = (1000 + round (random (5000)));			//Tabs for crate1
	};
};


// Define spawn locations for AI Soldiers. These will be used for the initial spawning of AI as well as reinforcements.
// The center spawn location is added 3 times so at least 3 AI will spawn initially at the center location, and so that future reinforcements are more likely to spawn at the center.
_AISoldierSpawnLocations =	[
								[26997.8,23248,0],
								[27032.4,23204.6,0],
								[27095.1,23247.7,0],
								[27139.4,23342.9,0],
								[27082,23375.6,0]
							];
// Rooftop snipers as 2nd group (20 max) - no reinforcements of these.
_AISniperSpawnLocations = 	[
								[26976.4,23295.9,0],
								[27106.2,23192.4,0],
								[26991.4,23203.1,0],
								[27092.3,23297.2,0],
								[27051.2,23111.8,0]
							];
// Shuffle the list of possible sniper spawn locations
_AISniperSpawnLocations = _AISniperSpawnLocations call ExileClient_util_array_shuffle;	

// Vehicle patrol locations							
_AIPatrolSpawnLocations = 	[
								[27148.8,23212.4,0],
								[27101.5,23397.6,0]
							];
// Shuffle the list of possible patrol spawn locations
_AIPatrolSpawnLocations = _AIPatrolSpawnLocations call ExileClient_util_array_shuffle;							

_group =	[
				_AISoldierSpawnLocations+[_pos,_pos,_pos],		// Pass the regular spawn locations as well as the center pos 3x
				_AICount,						// Set in difficulty select
				_difficulty,						// Set in difficulty select
				"random",
				_side
			] call DMS_fnc_SpawnAIGroup_MultiPos;

_group2 =	[
				_AISniperSpawnLocations,				// Snipers on rooftops
				_AICountSnipers,					// Set in difficulty select
				_difficulty,						// Set in difficulty select
				"sniper",
				_side
			] call DMS_fnc_SpawnAIGroup_MultiPos;
			
_group3 =	[                                                       		// Helicopter support group
				_pos,                 					// Heli reinforcements
				1,
				"random",
				"random",
				"bandit"
			] call DMS_fnc_SpawnAIGroup;
			[
			_group3,
			"random",
			"difficult",
			"bandit",
			_pos,
			true,
			5,
			false,
			"Exile_Chopper_Huey_Armed_Green"
			] call DMS_fnc_SpawnHeliReinforcement;

_staticGuns =	[
					[
						_pos vectorAdd [-5,0,0],	// 5 meters East of center pos
						_pos vectorAdd [0,-5,0],	// 5 meters South of center pos
						_pos vectorAdd [5,0,0],		// 5 meters West of center pos
						_pos vectorAdd [0,5,0],		// 5 meters North of center pos						
						[27052.8,23315.8,25.4922],
						[27135.3,23270.1,27.4871],
						[27083.6,23139.9,25.0863]

					],
					_group,
					"assault",
					_difficulty,
					"bandit",
					"random"
				] call DMS_fnc_SpawnAIStaticMG;

// add vehicle patrol
_veh =	[
			[
				[27148.8,23212.4,0]
			],
			_group,
			"assault",
			_difficulty,
			_side
		] call DMS_fnc_SpawnAIVehicle;

// Create Buildings - this is so roadblocks only appear during mission
_baseObjs =	[
				"molos_siege_buildings"
			] call DMS_fnc_ImportFromM3E_3DEN_Static;
			
// Define the classnames and locations where the crates can spawn (at least 2, since we're spawning 2 crates)
_crateClasses_and_Positions =	[
									[[27043.4,23199.8,],"I_CargoNet_01_ammo_F"],
									[[27039,23193.8,],"I_CargoNet_01_ammo_F"]
								];

{
	deleteVehicle (nearestObject _x);		// Make sure to remove any previous crates.
} forEach _crateClasses_and_Positions;

// Shuffle the list
_crateClasses_and_Positions = _crateClasses_and_Positions call ExileClient_util_array_shuffle;

// Create Crates
_crate0 = [_crateClasses_and_Positions select 0 select 1, _crateClasses_and_Positions select 0 select 0] call DMS_fnc_SpawnCrate;
_crate1 = [_crateClasses_and_Positions select 1 select 1, _crateClasses_and_Positions select 1 select 0] call DMS_fnc_SpawnCrate;

// Enable smoke on the crates due to size of area
{
	_x setVariable ["DMS_AllowSmoke", true];
} forEach [_crate0,_crate1];

// Define mission-spawned AI Units
_missionAIUnits =	[
						_group, 		// Main AI
						_group2			// Snipers
						//_group3		//heli - if not included in the mission triggers and it wanders off it mission should still complete
					];

// Define the group reinforcements - dont include sniper _group2
_groupReinforcementsInfo =	
[
	[
		_group,			// pass the group
		[
			[
				5,		// Only 5 "waves" (5 vehicles can spawn as reinforcement over time)
				0
			],
			[
				-1,		// No need to limit the number of units since we're limiting "waves"
				0
			]
		],
		[
			_AIdelay,		// The delay between reinforcements. >> you can change this in difficulty settings
			diag_tickTime
		],
		[_AIPatrolSpawnLocations],	// Randomly chosen places for vehicle patrol respawn from 10 defined
		"random",
		_difficulty,
		_side,
		"armed_vehicle",
		[
			_AItrigger,		// Set in difficulty select - Reinforcements will only trigger if there's fewer than X members left
			"random"		// Select a random armed vehicle from "DMS_ArmedVehicles"
		]
	],
	[
		_group,			// pass the group again for foot troops
		[
			[
				0,		// Let's limit number of units instead...
				0
			],
			[
				_AIMaxReinforcements,	// Maximum units that can be given as reinforcements (defined in difficulty selection).
				0
			]
		],
		[
			_AIdelay,		// The delay between reinforcements. >> you can change this in difficulty settings
			diag_tickTime
		],
		[_AISoldierSpawnLocations],
		"random",
		_difficulty,
		_side,
		"reinforce",
		[
			_AItrigger,		// Set in difficulty select - Reinforcements will only trigger if there's fewer than X members left
			_AIwave			// X reinforcement units per wave. >> you can change this in mission difficulty section
		]
	]
];

// setup crates with items from choices
_crate_loot_values0 =	[
							_crate_weapons0,		// Set in difficulty select - Weapons
							_crate_items0,			// Set in difficulty select - Items
							_crate_backpacks0 		// Set in difficulty select - Backpacks
						];
_crate_loot_values1 =	[
							_crate_weapons1,		// Set in difficulty select - Weapons
							_crate_items1,			// Set in difficulty select - Items
							_crate_backpacks1 		// Set in difficulty select - Backpacks
						];

// add cash to crates
_crate0 setVariable ["ExileMoney", _cash0,true];
_crate1 setVariable ["ExileMoney", _cash1,true];

// is %chance greater than random number
if (_VehicleChance >= (random 100)) then {
											_pinCode = (1000 +(round (random 8999)));
											_vehicle = ["Exile_Car_Ural_Covered_Military",[27037.3,23201.3,0],_pinCode] call DMS_fnc_SpawnPersistentVehicle;
											_msgWIN = ['#0080ff',format ["Convicts have successfully cleared Molos and stolen all the crates, Ural entry code is %1...",_pinCode]];
											_Vwin = "Win";	//just for logging purposes
											} else
											{
											_vehicle = ["Exile_Car_Ural_Covered_Military",[27037.3,23201.3,0]] call DMS_fnc_SpawnNonPersistentVehicle;
											_msgWIN = ['#0080ff',"Convicts have successfully cleared Molos and stolen all the crates"];
											_Vwin = "Lose";	//just for logging purposes
											};

//export to logs for testing - comment next line out for no log
diag_log format ["Molos :: Called MISSION with these parameters: >>AI Group: %1  >>Cash0: %2 >>Cash1: %3 >>Vwin: %4 >>Difficulty: %5 >>Snipers: %6",_AICount,_cash0,_cash1,_Vwin,_difficultyM,_AICountSnipers];

// Define mission-spawned objects and loot values with vehicle
_missionObjs =	[
					_staticGuns+_baseObjs+[_veh],										// static gun(s). Road blocks. Patrol vehicles
					[_vehicle],															// vehicle prize
					[[_crate0,_crate_loot_values0],[_crate1,_crate_loot_values1]]		// crates
				];	

// Define Mission Start message
_msgStart = ['#FFFF00',format["Molos is being invaded by %1 terrorists",_difficultyM]];

// Define Mission Win message defined in vehicle choice

// Define Mission Lose message
_msgLOSE = ['#FF0000',"Invaders have stripped Molos of loot and left."];

// Define mission name (for map marker and logging)
_missionName = "Molos Invasion";

// Create Markers
_markers =	[
				_pos,
				_missionName,
				_difficultyM
			] call DMS_fnc_CreateMarker;

_circle = _markers select 1;
_circle setMarkerDir 0;
_circle setMarkerSize [250,250];

_time = diag_tickTime;

// Parse and add mission info to missions monitor
_added =	[
				_pos,
				[
					[
						"kill",
						[_group,_group2,_group3]
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
				_difficultyM,
				[[],[]]
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
