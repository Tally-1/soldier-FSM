params["_battleField"];
private _hunkerObjects = missionNamespace getVariable (_battlefield get "hunkerObjects");
if(isNil "_hunkerObjects")exitWith{};

Private _mapObjects    	= missionNamespace getVariable (_battlefield get "mapObjects");
Private _hunkerObjData 	= _mapObjects get "hunkerObjData";
private _distance 		= (_battleField get "radius") * 2;

{
	private _pos   = ASLToAGL (getPosASLVisual _X);
	private _key   = str _pos;
	private _data  = _hunkerObjData get _key;
	private _owner = (_data get "owner");
	
	if!(_owner == "none")
	then{
			private _text    = _owner;
			private _icon    = "\a3\UI_F_Enoch\Data\CfgMarkers\circle1_ca.paa";
			private _color   = [0.5,0.25,0,1];
			private _status  = _data get "status";;
			
			[
				_pos,
				_color,
				_text,
				_icon,
				1.5,
				_distance
			] call SFSM_fnc_drawObjectMarker;

			[
				(_data get "safe_pos"),
				[0.3,0.7,0,1],
				"",
				"\a3\UI_F_Enoch\Data\CfgMarkers\dot1_ca.paa",
				1.5,
				_distance
			] call SFSM_fnc_drawObjectMarker;

			[
				(_data get "fireLeft"),
				[0.7,0.3,0,1],
				"",
				"\a3\UI_F_Enoch\Data\CfgMarkers\dot1_ca.paa",
				1.5,
				_distance
			] call SFSM_fnc_drawObjectMarker;

			[
				(_data get "fireRight"),
				[0.7,0.3,0,1],
				"",
				"\a3\UI_F_Enoch\Data\CfgMarkers\dot1_ca.paa",
				1.5,
				_distance
			] call SFSM_fnc_drawObjectMarker;
			
			if!(_status get "canShoot")
			then{
					private _status1Pos = [_pos, 2] call Tcore_fnc_AddZ;
					private _color = [0.9, 0.5, 0,8, 1];
					private _text = "no LOS";
					[
						_status1Pos,
						_color,
						_text,
						"",
						1.5,
						_distance
					] call SFSM_fnc_drawObjectMarker;
				};

			if(_status get "needHeal")
			then{
					private _status2Pos = [_pos, 4] call Tcore_fnc_AddZ;
					private _color = [0.9, 0.5, 0,8, 1];
					private _text = "Need healing!";
					[
						_status2Pos,
						_color,
						_text,
						"",
						1.5,
						_distance
					] call SFSM_fnc_drawObjectMarker;
				};

			if!(_status get "safe")
			then{
					private _status3Pos = [_pos, 4] call Tcore_fnc_AddZ;
					private _color = [0.9, 0.5, 0,8, 1];
					private _text = "Need to shift";
					[
						_status3Pos,
						_color,
						_text,
						"",
						1.5,
						_distance
					] call SFSM_fnc_drawObjectMarker;
				};
	};
} forEach _hunkerObjects;




	// if (_data get "available")
	// then{
	// 		_icon = selectRandom["\a3\UI_F_Enoch\Data\CfgMarkers\circle1_ca.paa",
	// 							"\a3\UI_F_Enoch\Data\CfgMarkers\circle2_ca.paa",
	// 							"\a3\UI_F_Enoch\Data\CfgMarkers\circle3_ca.paa",
	// 							"\a3\UI_F_Enoch\Data\CfgMarkers\circle4_ca.paa",
	// 							"\a3\UI_F_Enoch\Data\CfgMarkers\pencilCircle1_ca.paa",
	// 							"\a3\UI_F_Enoch\Data\CfgMarkers\pencilCircle2_ca.paa",
	// 							"\a3\UI_F_Enoch\Data\CfgMarkers\pencilCircle3_ca.paa"];
	// 		private _alpha = random 1;
	// 		_color =[0.43, 1, 0,8, _alpha];
	// 	}; 