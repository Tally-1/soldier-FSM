params["_man"];
private _hunter = _man getVariable "SFSM_myAssasin";
private _victim = _man getVariable "SFSM_myTarget";

if(isNil "_hunter" && {isNil "_victim"})exitWith{false;};

private _color   = [0,1,0.9,1];
private _pos     = ASLToAGL(aimPos _man);
private _pingPos = [ASLToAGL(eyePos _man),1] call Tcore_fnc_AddZ;

if(!isNil "_hunter")then{[_man, _pos] call SFSM_fnc_dbgTxtSnipeTarget;};
if(!isNil "_victim")then{[_man, _pos] call SFSM_fnc_dbgTxtSniper;};

true;