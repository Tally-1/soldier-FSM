hint "Battlefield grid toggled";

if  ((!isNil "SFSM_Custom3Dpositions" )
    &&  {SFSM_Custom3Dpositions isNotEqualTo []})
    exitWith{
        hint "Battlefield grid OFF";
        SFSM_Custom3Dpositions = [];
    };
    
private _camPos = positionCameraToWorld [0,0,0];
private _battle = [] call SFSM_fnc_nearestBattle;

private _battleFound = typeName _battle == "hashmap";
if!(_battleFound) exitWith{
    hint "No battlefield found";
    false;
};

if((_battle get "center" distance2D _camPos) > ((_battle get "radius")*2))
exitWith{
    hint "Battlefield out of range";
    false;
};

SFSM_Custom3Dpositions = (missionNamespace getVariable (_battle get 'grid')) get "gridPositions";
hint "Battlefield grid ON";

true;