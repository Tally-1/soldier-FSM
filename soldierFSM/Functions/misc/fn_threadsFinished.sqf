params["_scriptList"];
private _finished = true;
isNil{
{
	if(scriptDone _x isEqualTo false)exitWith{_finished = false;};
	
} forEach _scriptList;
};

_finished;