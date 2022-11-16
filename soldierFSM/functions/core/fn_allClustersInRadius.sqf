//Defining default values, in case these are not passed into the function
// 
// EXAMPLE: [(getPos player), west, true] call Tcore_fnc_allClustersInRadius
// 
private _sides			 = [east, west, independent];
private _returnAllData   = false; 
private _radius 		 = 500;
private _clusterRadius 	 = 50;
private _Zvalue			 = 2;
private _includeTerrainObjects = false;

params[
		"_center", 
		"_sides",
		"_returnAllData",
		"_radius",
		"_clusterRadius", 
		"_Zvalue",
		"_includeTerrainObjects"
	];

if(typeName _sides == "SIDE")			then{_sides = [_sides]};

private _allUnitsVeh 	= _center nearEntities ["CAManBase", _radius];
private _positions      = [];
private _dataArr		= [];
private _excludedUnits  = [];

for "_I" from 0 to ((count _allUnitsVeh) -1)
do {
		private _unit = _allUnitsVeh select _I;
		private _side = side _unit;
		
		if((!(_unit in _excludedUnits))
		&&{_side in _sides
		&& {[_unit] call SFSM_fnc_isRealMan}})
		then{
				private _clusterData    = [	_unit, 
											_clusterRadius, 
											_Zvalue,
											_excludedUnits, 
											"all",
											_includeTerrainObjects
										  ] call Tcore_fnc_clusterPos;

				private _clusterPos     = _clusterData # 0;
				private _clusterMembers = _clusterData # 1;
				
				/*The clusterPos function will for some reason sometimes return a number instead of an array */
				if((!isNil "_clusterMembers")
				&&{(typeName _clusterMembers == "ARRAY")
				&&{count _clusterMembers >0}})
				then{
						 _positions pushBackUnique _clusterPos;
						 _dataArr   pushBackUnique _clusterData;
						_excludedUnits append _clusterMembers;
					};
			};
	};

if(_returnAllData)exitWith{_dataArr};

_positions