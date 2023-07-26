params["_fipo"];
private _side  = "undefined";
private _sides = [];
if(_fipo getVariable "alloweast")        then{_sides pushBack east;};
if(_fipo getVariable "allowindependent") then{_sides pushBack independent;};
if(_fipo getVariable "allowwest")        then{_sides pushBack west;};

private _count = count _sides;

if(_count isEqualTo 0) exitWith{"C_Soldier_VR_F";};
if(_count > 1)         exitWith{"C_Soldier_VR_F";};

private _side = _sides#0;
if(_side isEqualTo west)        exitWith{"B_Soldier_VR_F";};
if(_side isEqualTo east)        exitWith{"O_Soldier_VR_F";};
if(_side isEqualTo independent) exitWith{"I_Soldier_VR_F";};

"C_Soldier_VR_F";