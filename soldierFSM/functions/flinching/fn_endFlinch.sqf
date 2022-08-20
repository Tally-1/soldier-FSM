params ["_man", '_reactionTime', "_shooter"];
private _actionTime = 1.2;
private _sideStances = ["aadjppnemstpsraswrfldleft", "aadjppnemstpsraswrfldright"];

if(!isNil '_reactionTime')
then{_actionTime = _actionTime + _reactionTime};
	
	sleep _actionTime;
	[_man, "flinching", false] 	call SFSM_fnc_unitData;
	[_man, "action", "none"] 	call SFSM_fnc_unitData;

if ((stance _man) == "PRONE"
&&{(animationState _man) in _sideStances})
then{
		_man playMove "AmovPercMstpSrasWrflDnon_AmovPpneMstpSrasWrflDnon";
	};
sleep 1;
if(isNil "_man")exitWith{};

[_man] call SFSM_fnc_normalizeStance;

sleep 2;
if(isNil "_man")exitWith{};

private _canReactFire = [_man] call SFSM_fnc_canReactFire;

if(_canReactFire)then{[_man, _shooter] spawn SFSM_fnc_reactFire};