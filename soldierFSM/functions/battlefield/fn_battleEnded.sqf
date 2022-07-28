params ['_battleField'];
private _timePassed = time - (_battlefield get "Started");
private _name       = _battlefield get 'name';

if(_timePassed < 60)exitwith{false};

private  _sides = (_battlefield get "sides") call SFSM_fnc_sidesFromString;
if(count _sides < 2)
exitWith{
			[[str (_sides#0), ' Has won battle at ', _name, '!']] call dbgmsg;
			true;
		};


private  _unitsFighting = [_battleField] call SFSM_fnc_battlingUnits;

if(count _unitsFighting < 2)
exitWith{
			[['Ending battle at ', _name, '. Less than 2 units currently engaging.']] call dbgmsg;
			true
		}; 

false;