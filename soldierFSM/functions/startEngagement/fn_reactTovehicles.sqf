params ["_man", "_battleField"];

private _action = [_man, "action"] call SFSM_fnc_unitData;
private _occupied = ("Hiding" in _action || "Targeting" in _action);
private _playerLead = ((leader (group _man)) in allPlayers);


if(_occupied)exitWith{false};

//get nearest high-level enemy vehicle
private _majorThreat = [_man, _battleField] call SFSM_fnc_unkillableEnemyVehicle;


//proceed as normal if there are no enemy high-level vehicle
if(isNull _majorThreat)exitWith{false};



//Performance-wise this block would be better to put before the threat-check, 
//however the debug-message might cause confusion for testers if there are no vehicles present at the battlefield
if(_playerLead 
&& {!(SFSM_PlayerGrpDodge)})
exitWith{
			"player groups blocked from dodging, will not hide from vehicles" call dbgmsg; 
			false;
		};


//check visibility
private _manPos          = eyePos _man;
private _enemyPos        = eyePos _majorThreat;
private _visibleToThreat = ([_man, "VIEW", _majorThreat] checkVisibility [_manPos, _enemyPos]) > 0.1;


//proceed as normal if man cannot be seen by enemy vehicle
if!(_visibleToThreat)exitWith{false};

private _atSpecialist = ([_man] call SFSM_fnc_squadAsset) == "AT-specialist";
private _hasAtAmmo    = [_man, (secondaryWeapon _man)] call SFSM_fnc_hasAmmoForWeapon;

//if a vehicle is found and the man has a AT launcher, then repeat init-fight actions
if(_atSpecialist
&&{_hasAtAmmo
&&{SFSM_AtSpecHuntVehicles}})
exitWith{[_man] spawn SFSM_fnc_AtSpecialistInitFight; true};


//if there is a high-level threat present and the man has no launcher or no misiles.

if!(SFSM_hideFromVehicles)exitWith{"Man will not hide, hiding has been deactivated" call dbgmsg; false;};

private _hidePos = [_man, _majorThreat] call SFSM_fnc_findHidePos;
private _posFound = typeName _hidePos == "ARRAY";

if(_posFound)
exitWith{
			[_man, _hidePos, _majorThreat] spawn SFSM_fnc_hideFromVehicle;
			true;
		}; 


//If no hidden positions are found in the battlefield-grid, a standard coverPosition will be used
private _hideDir = _majorThreat getDir _man;
private _searchPos = getPos _man;
_searchPos = [_searchPos#0, _searchPos#1, _hideDir, SFSM_DodgeDistance] call Tcore_fnc_sinCosPos;

_hidePos = [_man, _searchPos, (SFSM_DodgeDistance*2)] call SFSM_fnc_getCoverPos;
_posFound = (!isNil "_hidePos" && {typeName _hidePos == "ARRAY"});

if(_posFound)
exitWith{
			[_man, _hidePos, _majorThreat] spawn SFSM_fnc_hideFromVehicle;
			true;
		};


"No place to hide found, running away from vehicle" call dbgmsg;

if!(surfaceIsWater _searchPos)
exitWith{[_man, _searchPos, _majorThreat] spawn SFSM_fnc_hideFromVehicle; true};

false;