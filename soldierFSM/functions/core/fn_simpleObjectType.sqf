params["_object"];
private _name = "";
isNil{//Forced unscheduled execution
      // < "3374684b400# 122614: radar_f.p3d" > Split between : and . because name can't contain these -
      // letters so the name is always in between
    private _stringName = str _object;
    private _string = (((_stringName splitString ":") # 1) splitString ".") # 0;
    if(isNil "_string")exitWith {""};
    _name = _string select [1, count _string]; // Get rid of the whitespace
    // if (isNil "_name") then {_name = ""};
};

_name;