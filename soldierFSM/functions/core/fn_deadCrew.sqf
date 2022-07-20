params ["_Vehicle"];
private _Group   = (group _Vehicle);
private _AllDead = true;

if(IsNil "_Vehicle")			exitWith{true};
if((crew _Vehicle) isEqualTo [])exitwith{true};
if(!Alive _Vehicle)				exitWith{true};
if(IsNil "_Group")				exitWith{true};
if(IsNull _Group) 				exitWith{true};


{if(alive _X)exitWith{_AllDead = false}} forEach (Crew _Vehicle);





_AllDead