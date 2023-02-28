params["_man"];

private _eh = 
_man addEventHandler ["AnimDone", {
	params ["_man", "_anim"];

	//men will sometimes revert to the previous position, I am using setPos in order to work around that
	private _pos = getPosASL _man;
	
	
	//get relevant data, defined in  SFSM_fnc_sprintInit
	private _segmentDone  = _anim == "AmovPercMevaSrasWrflDf";
	private _i            = _man getVariable "SFSM_SprintSegmentsDone";
	private _destination  = _man getVariable "SFSM_SprintDestination";
	private _remainDist   = _man distance2D _destination;
	
	//define exit conditions
	private _segMaxed     = _i > (_man getVariable "SFSM_maxSegments");
	private _timedOut     = time > (_man getVariable "SFSM_SprintTimer");
	private _arrived      = _remainDist < 3;
	private _dead         = !alive _man;
	private _unconscious  = _man getVariable ["ace_isunconscious", false];

	//check if any of the exit conditions has been fulfilled
	private _endLoop      = _segMaxed || _timedOut || _arrived || _dead || _unconscious;
	
	//end sprint
	if(_endLoop)exitWith{
		// _man setPosASL _pos;
		[_man] call SFSM_fnc_sprintVarRemoval;
	};

	//repeat the same move again
	if(_segmentDone)then{

		private _wantedDir      = _man getDir _destination;
		private _needsAdjusting = !([(getDir _man), _wantedDir,2] call Tcore_fnc_inDirRange);
		if(_needsAdjusting)then{_man setDir _wantedDir};

		_man setVariable ["SFSM_SprintSegmentsDone", (_i+1)];
		[_man,  "AmovPercMevaSrasWrflDf"] remoteExecCall ["playMoveNow", 0];
	};

	true;

}];

_man setVariable ["SFSM_SprintEh", _eh];

true;