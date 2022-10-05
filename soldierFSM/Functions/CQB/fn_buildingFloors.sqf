params["_buildingPositions"];
private _floors = 1;
private _zValues = [];
{_zValues pushBack _x#2;} forEach _buildingPositions;

private _diff = (selectMax _zValues) -(selectMin _zValues);

if(_diff > 2)
then{_floors = 2};

_floors;