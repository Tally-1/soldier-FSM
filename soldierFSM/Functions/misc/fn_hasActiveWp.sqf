params ["_group"];
private _totalWPs  = count waypoints _group;
private _currentWp = currentWaypoint _group;
if(_totalWPs  isEqualTo _currentWp)exitWith{false;};

true;