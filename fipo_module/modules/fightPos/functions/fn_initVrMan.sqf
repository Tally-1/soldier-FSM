params ["_vrMan", "_fipo", "_useColor"];

_vrMan setVariable ["SFSM_fipo", _fipo];
_vrMan enableSimulation false;
_vrMan set3DENAttribute ["Init", "this setVariable ['fipo_ind', true]; deleteVehicle this;"];
_vrMan set3DENAttribute ["Player", "false"];
_vrMan addWeapon "arifle_AKM_F";

/*
    I wanted to have a specific color for the man in cover, in order to more easily
    distinguish between the firing stances and the cover stance, however
 */
// if(_useColor)then{
//     [_vrMan, "...",0]  call FIPO_fnc_setTextTexture;
//     [_vrMan, "...",1]  call FIPO_fnc_setTextTexture;
//     [_vrMan, "...",2]  call FIPO_fnc_setTextTexture;
//     [_vrMan, "...",3]  call FIPO_fnc_setTextTexture;
//     [_vrMan, "...",4]  call FIPO_fnc_setTextTexture;
//     [_vrMan, "...",5]  call FIPO_fnc_setTextTexture;
//     [_vrMan, "X","clan"]  call FIPO_fnc_setTextTexture;
// };


_vrMan;