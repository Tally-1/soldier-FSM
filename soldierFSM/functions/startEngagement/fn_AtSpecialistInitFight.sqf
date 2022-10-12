params ["_man"];
private _battleKey     = [_man, "currentBattle"] call SFSM_fnc_unitData;
private _battlefield   = SFSM_Battles get _battleKey;
private _gridPositions = (missionNamespace getVariable (_battlefield get 'grid')) get "gridPositions";
private _enemyVehicles = [_man, _battlefield] call SFSM_fnc_getEnemyVehicles;
private _enemies       = [_man] call Tcore_fnc_nearKnownEnemies;
private _noAtAmmo      = !([_man, (secondaryWeapon _man)] call SFSM_fnc_hasAmmoForWeapon);
private _noEnemyVeh    = count _enemyVehicles == 0;


if(_noEnemyVeh
|| (_noAtAmmo))
exitWith{
			private _text = "No enemy vehicles";
			if(_noAtAmmo)then{_text = "No ammo for launcher"};
			
			[_man, _battlefield, _text] 
			spawn	{
						params ["_man", "_battlefield", "_text"];
						[_man, "action", _text] call SFSM_fnc_unitData;
						sleep 3;
						[_man, "action", "none"] call SFSM_fnc_unitData;
						[_man, _battlefield]  call SFSM_fnc_fightInitCover;
					};
		};


private _targetVehicle = [_man, _enemyVehicles] call Tcore_fnc_nearestPos;
private _timer = time + 30;

[_man, "action", "Targeting vehicle"] call SFSM_fnc_unitData;
_man doTarget objnull;
_man reveal [_targetVehicle, 4];
_man doTarget _targetVehicle;

while{
		sleep 3; 
		private _crewPresent    = !([_targetVehicle] call Tcore_fnc_deadCrew);
		private _hasAtAmmo      = ([_man, (secondaryWeapon _man)] call SFSM_fnc_hasAmmoForWeapon);

		(time < _timer 
		&& {alive _man
		&&{_crewPresent
		&&{_hasAtAmmo}}})
	}
do{
		_hasAtAmmo = ([_man, (secondaryWeapon _man)] call SFSM_fnc_hasAmmoForWeapon);
		if!(_hasAtAmmo) exitWith {};
		
		if!(assignedTarget _man == _targetVehicle)
		then
		{
			_man doTarget objnull;
			sleep 0.1;
			_man doTarget _targetVehicle;

			//the selectWeapon command is buggy, and will usually only work on players...
			if((currentWeapon _man) != (secondaryWeapon _man))
			then{_man selectWeapon (secondaryWeapon _man); sleep 1};

			_man doFire _targetVehicle;
		};
		
		if!([_man, _targetVehicle] call SFSM_fnc_targetVisible)
		then{
				private _hiddenPos = (_targetVehicle getVariable "SFSM_vehicleData")get "hiddenPos";
				if(isNil '_hiddenPos')exitWith{};
				if(isNil '_gridPositions')exitWith{};
				if(typeName _hiddenPos != 'ARRAY')exitWith{};
				private _firePositions = _gridPositions select {! (_x in _hiddenPos)};
				private _nearest =  ([_firePositions, [], {_man distance _x }, "ASCEND"] call BIS_fnc_sortBy)#0;
				
				if!(isNil '_nearest')then{_man doMove _nearest;};
		}
		else{
				if((currentWeapon _man) != (secondaryWeapon _man))
				then{_man selectWeapon (secondaryWeapon _man); sleep 1};

				_man doFire _targetVehicle;
		};
		


		sleep 3;
	};


[_man, "action", "none"] call SFSM_fnc_unitData;
_man doMove (getPos _man);
_man doFollow leader (group _man);

[_man] call SFSM_fnc_postCoverActions;