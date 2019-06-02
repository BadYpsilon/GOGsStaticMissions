/*
	"Submarine Accident" v1.0 static mission for Altis.
	Created by Cloudskipper using templates by eraser1
	Reinforcements of AI vehicle patrols, 2 different groups of AI so one is dedicated sniper
	This version includes AI heli - thanks to aussie battler for help with this
	Diffficulty of mission not linked to difficulty of AI if you want.
	easy/mod/difficult/hardcore - reworked by [CiC]red_ned http://cic-gaming.co.uk
*/

private ["_AICount", "_AICountSnipers", "_AIMaxReinforcements", "_AItrigger", "_AIwave", "_AIdelay", "_staticguns", "_missionObjs", "_crate0", "_crate1", "_cash0", "_cash1", "_crate_loot_values0", "_crate_loot_values1", "_crate_weapons0", "_crate_weapons1", "_crate_items0", "_crate_items1", "_crate_backpacks0", "_crate_backpacks1", "_difficultyM", "_difficulty", "_PossibleDifficulty", "_msgWIN", "_vehicle", "_pinCode", "_VehicleChance", "_baseObjs", "_AISniperSpawnLocations", "_AIPatrolSpawnLocations", "_group2", "_group3", "_veh", "_Vwin", "_dropPoint", "_heliClass", "_spawnPos", "_RandomeVehicle", "_PossibleVehicle"];

// For logging purposes
_num = DMS_MissionCount;

// Set mission side (only "bandit" is supported for now)
_side = "bandit";

_pos = [21993.4,21049.7,0]; //insert the centre here

if ([_pos,DMS_StaticMinPlayerDistance] call DMS_fnc_IsPlayerNearby) exitWith {"delay"};

//create possible difficulty add more of one difficulty to weight it towards that
_PossibleDifficulty		= 	[	
								"easy",
								"moderate",
								"moderate",
								"difficult",
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
		_difficulty = "easy";									//AI difficulty
		_AICount = (10 + (round (random 5)));					//AI starting numbers
		_AICountSnipers = (2 + (round (random 4)));				//Max 6
		_AIMaxReinforcements = (10 + (round (random 5)));		//AI reinforcement cap
		_AItrigger = (10 + (round (random 2)));					//If AI numbers fall below this number then reinforce if any left from AIMax
		_AIwave = (4 + (round (random 2)));						//Max amount of AI in reinforcement wave
		_AIdelay = (55 + (round (random 120)));					//The delay between reinforcements
		_VehicleChance = 25;									//25% SpawnPersistentVehicle chance
		_crate_weapons0 	= (20 + (round (random 25)));		//Crate 0 weapons number
		_crate_items0 		= (5 + (round (random 20)));		//Crate 0 items number
		_crate_backpacks0 	= (3 + (round (random 1)));			//Crate 0 back packs number
		_crate_weapons1 	= (25+ (round (random 20)));		//Crate 1 weapons number
		_crate_items1 		= (10 + (round (random 40)));		//Crate 1 items number
		_crate_backpacks1 	= (1 + (round (random 8)));			//Crate 1 back packs number
	};
	case "moderate":
	{
		_difficulty = "moderate";
		_AICount = (10 + (round (random 7)));					//Max 17
		_AICountSnipers = (4 + (round (random 4)));				//Max 8
		_AIMaxReinforcements = (10 + (round (random 10)));
		_AItrigger = (10 + (round (random 4)));
		_AIwave = (5 + (round (random 3)));
		_AIdelay = (55 + (round (random 120)));
		_VehicleChance = 50;									//50% SpawnPersistentVehicle chance
		_crate_weapons0 	= (30 + (round (random 25)));
		_crate_items0 		= (10 + (round (random 15)));
		_crate_backpacks0 	= (3 + (round (random 1)));
		_crate_weapons1 	= (25 + (round (random 30)));
		_crate_items1 		= (20 + (round (random 30)));
		_crate_backpacks1 	= (5 + (round (random 5)));
	};
	case "difficult":
	{
		_difficulty = "difficult";
		_AICount = (10 + (round (random 10)));
		_AICountSnipers = (6 + (round (random 6)));				//Max 12
		_AIMaxReinforcements = (10 + (round (random 15)));
		_AItrigger = (10 + (round (random 6)));
		_AIwave = (6 + (round (random 3)));
		_AIdelay = (55 + (round (random 120)));
		_VehicleChance = 75;									//75% SpawnPersistentVehicle chance
		_crate_weapons0 	= (40 + (round (random 25)));
		_crate_items0 		= (15 + (round (random 10)));
		_crate_backpacks0 	= (3 + (round (random 3)));
		_crate_weapons1 	= (25 + (round (random 40)));
		_crate_items1 		= (30 + (round (random 20)));
		_crate_backpacks1 	= (6 + (round (random 6)));
	};
	//case "hardcore":
	default
	{
		_difficulty = "hardcore";
		_AICount = (10 + (round (random 15)));
		_AICountSnipers = (8 + (round (random 8)));			//Max 16
		_AIMaxReinforcements = (10 + (round (random 20)));
		_AItrigger = (10 + (round (random 8)));
		_AIwave = (6 + (round (random 4)));
		_AIdelay = (55 + (round (random 120)));
		_VehicleChance = 90;									//90% SpawnPersistentVehicle chance
		_crate_weapons0 	= (50 + (round (random 25)));
		_crate_items0 		= (20 + (round (random 25)));
		_crate_backpacks0 	= (2 + (round (random 5)));
		_crate_weapons1 	= (25 + (round (random 50)));
		_crate_items1 		= (40 + (round (random 25)));
		_crate_backpacks1 	= (10 + (round (random 2)));
	};
};

// Define spawn locations for AI Soldiers. These will be used for the initial spawning of AI as well as reinforcements.
// The center spawn location is added 3 times so at least 3 AI will spawn initially at the center location, and so that future reinforcements are more likely to spawn at the center.
_AISoldierSpawnLocations =	[
								[22026.1,21032.9,0.05],
								[22006.1,21063.6,0.05],
								[21972.8,21083,0.05],
								[22072.4,21105.5,0.05],
								[22082.7,21117,0.05],
								[21921.8,21050.9,0.05],
								[21901.8,21013.8,0.05],
								[21822.3,21019.7,0.05],
								[21830,21063.2,0.05],
								[21761.6,21063.9,0.05],
								[21732.4,20958.8,0.05],
								[21935.4,20989.7,0.05],
								[21789.2,20859.8,0.05],
								[21772.1,20869.8,0.05],
								[21723.2,20867.6,0.05],
								[21693.4,20867.8,0.05],
								[21677.5,20867.9,0.05]
							];
// Snipers as 2nd group (16 max) - no reinforcements of these.
_AISniperSpawnLocations = 	[
								[22096.1,21037.2,0.05],
								[22132.1,21234.9,0.05],
								[21924.9,21212.8,0.05],
								[21907.1,21189.4,0.05],
								[21883.9,21188,0.05],
								[21861.4,21178.8,0.05],
								[21690.6,21116.1,0.05],
								[21639.6,21075.6,0.05],
								[21616.5,21042.3,0.05],
								[21601.4,21009.3,0.05],
								[21926.3,21056.7,0.05],
								[21841,21064.5,0.05],
								[21773.3,21065.9,0.05],
								[21940.4,20942,0.05],
								[21963.5,20944.3,0.05],
								[21941.2,20918.5,0.05],
								[21863.2,20841.7,0.05],
								[21515.1,21014.5,0.05],
								[21575.5,21097.5,0.05]
							];
// Shuffle the list of possible sniper spawn locations
_AISniperSpawnLocations = _AISniperSpawnLocations call ExileClient_util_array_shuffle;	

// Vehicle patrol locations							
_AIPatrolSpawnLocations = 	[
								[21660.5,21210.9,0.10],
								[22165.3,21136.5,0.10],
								[21928.5,20974.9,0.10],
								[21785.6,20881.5,0.10],
								[22040.5,21080.8,0.10]								
							];
// Shuffle the list of possible patrol spawn locations
_AIPatrolSpawnLocations = _AIPatrolSpawnLocations call ExileClient_util_array_shuffle;							

_group =	[
				_AISoldierSpawnLocations+[_pos,_pos,_pos],			// Pass the regular spawn locations as well as the center pos 3x
				_AICount		,									// Set in difficulty select
				_difficulty,										// Set in difficulty select
				"random",
				_side
			] call DMS_fnc_SpawnAIGroup_MultiPos;

_group2 =	[
				_AISniperSpawnLocations,							// Snipers 
				_AICountSnipers,									// Set in difficulty select
				_difficulty,										// Set in difficulty select
				"sniper",
				_side
			] call DMS_fnc_SpawnAIGroup_MultiPos;
			
_staticGuns =	[
					[
						_pos vectorAdd [0,0,0],			// Center pos
						_pos vectorAdd [0,-2,0],		// 2 meters South of center pos
						[21970.5,21014.1,10.200],
						[21959.8,21024.3,10.175],
						[21785.7,21032.6,3.865],
						[21747,21004.4,3.650],
						[21888.4,21034.8,7.500],
						[22066.1,21114.5,2.282],
						[22082.5,21097.8,2.261]
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
				[22040.5,21080.8,0.10]
			],
			_group,
			"assault",
			_difficulty,
			_side
		] call DMS_fnc_SpawnAIVehicle;

// Create Buildings - this is so roadblocks only appear during mission
_baseObjs =	[
				"gogs_submarine_buildings"
			] call DMS_fnc_ImportFromM3E_3DEN_Static;
			
// Define the classnames and locations where the crates can spawn (at least 2, since we're spawning 2 crates)
_crateClasses_and_Positions =	[
									[[21977.5,21027.8,6.655],"I_CargoNet_01_ammo_F"],
									[[21967.0,21033.6,8.700],"I_CargoNet_01_ammo_F"],
									[[21874.6,20915.2,2.010],"I_CargoNet_01_ammo_F"],
									[[21728.4,20882.0,0.010],"I_CargoNet_01_ammo_F"],
									[[21784.4,21052.0,0.010],"I_CargoNet_01_ammo_F"],
									[[22070.9,21048.2,0.510],"I_CargoNet_01_ammo_F"]
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
		_AIPatrolSpawnLocations,	// Randomly chosen places for vehicle patrol respawn from 5 defined
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
		_AISoldierSpawnLocations,
		"random",
		_difficulty,
		_side,
		"reinforce",
		[
			_AItrigger,		// Set in difficulty select - Reinforcements will only trigger if there's fewer than X members left
			_AIwave			// X reinforcement units per wave. >> you can change this in mission difficulty section
		]
	],
	[
		_group,			// pass the group
		[
			[
				1,		// Only 1 "wave" 
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
		_pos,								// Randomly chosen places for vehicle patrol respawn from 10 defined
		"random",
		_difficulty,
		_side,
		"heli_troopers",
		[
			7,							// SCALAR: If the AI Group has fewer than "_AICount" living units, then the group will receive reinforcements.
		        false,       						// BOOLEAN: Whether or not to eject Fire-From-Vehicle (FFV) gunners.
		        999,           						// SCALAR: Maximum number of AI to eject from the aircraft. Set to a really high # to ignore (like 999).
		        false,       						// BOOLEAN: Whether or not to keep the heli flying around as a gunship.
		        [22023.71,21080.303,100.0],        			// OBJECT or ARRAY (OPTIONAL - Position2D or 3D): The location to drop the reinforcements at. The drop point will default to the group leader.
		        "B_Heli_Transport_03_F"   				// STRING (OPTIONAL): The classname of the heli to spawn.
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


//A list of possible vehicles add more of one vehicle to weight it towards that
_PossibleVehicle		= 	[
									"Exile_Car_Strider", // Strider
									"Exile_Car_Hunter", // Hunter
									"Exile_Car_Ifrit"  // Ifrit
							];
//choose difficulty and set value
_RandomeVehicle = selectRandom _PossibleVehicle;

// is %chance greater than random number
if (_VehicleChance >= (random 100)) then {
											_pinCode = (1000 +(round (random 8999)));
											_vehicle = [_RandomeVehicle,[21985.8,21059.1,0.10],_pinCode] call DMS_fnc_SpawnPersistentVehicle;
											_msgWIN = ['#0080ff',format ["Convicts were able to seize the submarine and its cargo, entry code is %1...",_pinCode]];
											_Vwin = "Win";	//just for logging purposes
											} else
											{
											_vehicle = [_RandomeVehicle,[21985.8,21059.1,0.10]] call DMS_fnc_SpawnNonPersistentVehicle;
											_msgWIN = ['#0080ff',"Convicts were able to seize the submarine and its cargo."];
											_Vwin = "Lose";	//just for logging purposes
											};

//export to logs for testing - comment next line out for no log
diag_log format ["Submarine Accident :: Called MISSION with these parameters: >>AI Group: %1 >>Vwin: %2 >>Difficulty: %3 >>Snipers: %4",_AICount,_Vwin,_difficultyM,_AICountSnipers];

// Define mission-spawned objects and loot values with vehicle
_missionObjs =	[
					_staticGuns+_baseObjs+[_veh],										// static gun(s). Road blocks. Patrol vehicles
					[_vehicle],															// vehicle prize
					[[_crate0,_crate_loot_values0],[_crate1,_crate_loot_values1]]		// crates
				];	

// Define Mission Start message
_msgStart = ['#FFFF00',format["A nuclear submarine has stranded on a sandbank, radioactivity has leaked. %1 armed troops have started the maintenance work",_difficultyM]];

// Define Mission Win message defined in vehicle choice

// Define Mission Lose message
_msgLOSE = ['#FF0000',"The submarine has disappeared into the depths of the ocean again, the radioactivity remains....."];

// Define mission name (for map marker and logging)
_missionName = "Submarine Accident";

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
						[_group,_group2]
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
