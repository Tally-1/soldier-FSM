//Copyright: Erlend Kristensen(c) 2023, learnbymistake@gmail.com
// BSD 3-Clause License     
// Author:         Leo Hartgen (Tally-1)
// Author links:   
//              https://github.com/Tally-1, 
//              https://thehartgen.web.app/projects/, 
//              https://www.fiverr.com/hartgen_dev/script-anything-you-can-think-of-in-arma-3

// Description:  This function is used to find the nearest weapon on the battlefield. 
// Params:       [_man:object, _battleField:hashmap, _type:string]
// Return value: _selectedWeapon:object
// Example:      [player, "battle_Pyrgos", "launcher"] call SFSM_fnc_getBattlefieldWeapon;

private _type = "launcher";
params ["_man", "_battleField", "_type"];
private _searchRadius  = selectMax [60, SFSM_DodgeDistance];
private _unitPos       = getPos _man;
private _weapons       = missionNamespace getVariable (_battlefield get "weapons");
        _weapons       = _weapons inAreaArray [_unitPos, _searchRadius, _searchRadius];

if(_weapons isEqualTo [])exitWith{};

private _units         = missionNamespace getVariable (_battleField get "units");
private _destinations  = [];
private _weaponClasses = [];
private _usableWeapons = [];

if(_type isEqualTo "launcher"
&&{!([_man] call SFSM_fnc_needLauncher)})exitWith{};

if(_type isEqualTo "launcher")then{_weaponClasses = [4, 4.01, 4.1, 4.3, 4.4]};

{
    private _weapon = _X;
    if((!isNil "_weapon"))
    then{
            private _weaponName      =  getWeaponCargo _X#0#0;
            private _weaponData      = createHashmap;

            if(!isNil "_weaponName")
            then{
                    _weaponData = [_weaponName] call objScan_fnc_weaponData;
            private _weaponClass     = _weaponData get "class ID";
            private _weaponOwner     = _weapon getVariable "SFSM_newOwner";
            private _correctType     = _weaponClass in _weaponClasses;
            private _weaponAvailable = (isNil "_weaponOwner");
            if!(_weaponAvailable)then{_weaponAvailable = (!alive _weaponOwner)};
            

            if(_weaponAvailable
            &&{_correctType
            &&{!isNull _weapon}})
            then{_usableWeapons pushBack _weapon};

        }};

} forEach _weapons;

if(_usableWeapons isEqualTo [])exitWith{};

private _selectedWeapon = [_man, _usableWeapons] call Tcore_fnc_nearestPos;

_selectedWeapon;