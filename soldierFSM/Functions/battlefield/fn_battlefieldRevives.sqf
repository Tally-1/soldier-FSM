params["_categorizedUnits", "_maxHealCount"];
private _incapacitated = [_categorizedUnits#5] call SFSM_fnc_sortUnconscious;
private _healers = [
	_maxHealCount,         // Total amount of potential healers
	_incapacitated,        // Incapacitated
	(_categorizedUnits#0), // medics 
	(_categorizedUnits#1), // fipoMedics
	(_categorizedUnits#2), // regulars (riflemen)
	(_categorizedUnits#3)  // specialists
	
	] call SFSM_fnc_sortRevivers;

private _assignedHealers = [];
{
    private _pos        = getPosATLVisual _x;
	if(_pos#2 < 0)then{_x setPos [_pos#0, _pos#1, 0.2];};//ACE ground break fix
	private _reviver =  [_x, _healers, _assignedHealers] call SFSM_fnc_nearestValidReviver;
	
	if(!isNil "_reviver")then{
            [_reviver, _x] spawn SFSM_fnc_buddyRevive;
			_assignedHealers pushBack _reviver;
    }else{
		[_x, "no available reviver..."] call SFSM_fnc_flashAction;
	};
	
} forEach _incapacitated;

private _healerCount = count _assignedHealers;
if(_healerCount isEqualTo 0)exitWith{
	"Could not assign any revivers" call dbgmsg;
};

[["Assigned ", _healerCount, " healers to revive Wounded."]] call dbgmsg;