params["_man"];
if(secondaryWeapon _man isEqualTo "")             exitWith{false;};

private _infantryData    = [_man] call objScan_fnc_infGearData;
private _unitDescription =  _infantryData get "description";
private _AT_strings      = ["RPG", "AT-misile"];
private _ATspecialist    = false;


{if(_x in _unitDescription)exitWith{_ATspecialist = true}} forEach _AT_strings;

_ATspecialist;