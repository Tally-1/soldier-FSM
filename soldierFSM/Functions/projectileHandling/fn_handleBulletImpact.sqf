params ["_launchPos", "_impactPos"];
//handle overflow
if(time - SFSM_lastImpactHandler < 10)exitWith{};

//this function is ment to help survive snipers, 
//hence the distance needs to be high.
//Lowering the distance could lead to performance issues.
private _distance = _launchPos distance2D _impactPos;
if(_distance < 400)exitWith{};

//convert to AGL format
_launchPos = ASLToAGL _launchPos;
_impactPos = ASLToAGL _impactPos;

//get necesary data and near units.
private _radius = 20;
private _nearMen = [_shooter, _distance] call Tcore_fnc_nearSoldiers;
if(_nearMen isEqualTo [])exitWith{};

//Send all units within set radius into cover / run away from impact
private _unitsReacted = 0;
{
	private _action      = [_X, "action"]        call SFSM_fnc_unitData;
	private _lastCover   = [_x, "last_time_in_cover"] call SFSM_fnc_unitData;
	private _noCoverSpam = (time - _lastCover) > (SFSM_stayCoverPosTime + 60);
	private _notInBattle = (([_X, "currentBattle"] call SFSM_fnc_unitData) == "none");

	if(_action == "none"
	&&{_noCoverSpam
	&&{_notInBattle}})
	then{
			[_x, _launchPos] call SFSM_fnc_eventTriggeredCover;
			_unitsReacted = _unitsReacted+1;
		};

} forEach _nearMen;

if(_unitsReacted > 0)then{[[_unitsReacted, "units hiding from bulletImpac"]] call dbgmsg};

//update impactHandler to avoid overflow / performance issues.
SFSM_lastImpactHandler = time;

true;