params["_man"];
private _infantryData    = [_man] call objScan_fnc_infGearData;
private _weaponClass     = (_infantryData get "weaponData") get "primary" get "class ID";
private _unitDescription =  _infantryData get "description";
private _AT_strings      = ["RPG", "AT-misile"];
private _ATspecialist    = false;
private _leader          = (leader (group _man)) == _man;

{if(_x in _unitDescription)exitWith{_ATspecialist = true}} forEach _AT_strings;


private _machineGunner = ((_weaponClass > 2.5 && {_weaponClass < 4})
						or(_weaponClass >= 1.7 && {_weaponClass <= 1.8}));

private _medic         = "Medikit" in (items _man);



if(_ATspecialist) exitWith{"AT-specialist"};
if(_machineGunner)exitWith{"machineGunner"};
if(_medic)        exitWith{"medic"};
if(_leader)       exitWith{"squad-leader"};


"regular"