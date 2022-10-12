params ['_battleField'];
private _timePassed = time - (_battlefield get "Started");
private _name       = _battlefield get 'name';

//Do not enda a battle if it just started.
if(_timePassed < 60)exitwith{false};

//end the battle if there is only 1 side left.
private  _sides = (_battlefield get "sides") call SFSM_fnc_sidesFromString;
if(count _sides < 2)
exitWith{
			[[str (_sides#0), ' Has won battle at ', _name, '!']] call dbgmsg;
			true;
		};


//Get the last unit who fired his weapon, and measure the time since he shot.
private _units = missionNamespace getVariable (_battleField get 'units');
_units = ([_units, [], { [_x, "last_bullet_fired"] call SFSM_fnc_unitData;}, "ASCEND"] call BIS_fnc_sortBy);
private _lastToShoot = _units#(count _units-1);
private _lastGunshot = [_lastToShoot, "last_bullet_fired"] call SFSM_fnc_unitData;
private _lastShotTime = time - _lastGunshot;


//End the battle if there are less than 2 units engaged and over 120s since last shot.
private  _unitsFighting = [_battleField] call SFSM_fnc_battlingUnits;
if(count _unitsFighting < 2
&&{_lastShotTime > 120})
exitWith{
			[['Ending battle at ', _name, '. ', _lastShotTime, ' Seconds since last shot']] call dbgmsg;
			true;
		}; 

false;