params["_fipo"];
if!(_fipo getVariable "showmarker")exitWith{false;};

private _text         = _fipo getVariable "posName";
private _randomNumber = round (random 1000000);
private _markerName   = [_text, _randomNumber] joinString "";
private _side         = _fipo getVariable "side";
private _color        = [_fipo] call SFSM_fnc_fipoMarkerColor;

private _markerstr = createMarker [_markerName, (getPosATL _fipo)];

_markerstr setMarkerShapeLocal "ICON";
_markerstr setMarkerTypeLocal  "loc_Rifle";
_markerstr setMarkerDirLocal   (getDir _fipo -45);
_markerstr setMarkerTextLocal  _text;
_markerstr setMarkerAlphaLocal 0.4;
_markerstr setMarkerColor  _color;

_fipo setVariable ["marker", _markerstr, true];
_fipo setVariable ["color",  _color, true];

true;