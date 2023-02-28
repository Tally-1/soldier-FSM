params["_man"];
if(isPlayer _man)exitwith{};
//if man is in a vehicle
if!(typeOf (vehicle _man) == typeOf _man)exitwith{};

private _3dPos		= (ASLToAGL getPosASL _man);
private _supp		= [(getSuppression _man), 2]call ObjScan_fnc_Decimals;
private _rps		= [_man, "roundsPrSecond"] 	call SFSM_fnc_unitData;
private _action		= [_man, "action"] 			call SFSM_fnc_unitData;

private _actionTxt   = _action;
private _supTxt		 = ["Supression: ", _supp] 		joinString "";
private _incomingTxt = [_rps, " Incoming rounds"] 	joinString "";

private _suppColor 	 = [_supp, 0.4, 0.4, 1];

private _sprinting   = _man getVariable ["SFSM_Sprinting", false];
private _unconscious = _man getVariable ["ace_isunconscious", false];
private _actionPos 	 = [(_3dPos # 0), (_3dPos # 1), ((_3dPos # 2) + 2.3)];
private _supPos 	 = [(_3dPos # 0), (_3dPos # 1), ((_3dPos # 2) + 2.1)];
private _incPos 	 = [(_3dPos # 0), (_3dPos # 1), ((_3dPos # 2) + 1.9)];
private _excluded    = _man getVariable ['SFSM_excluded', false];
private _excludedText = ["Excluded. Error: ", _action]joinString"";


// if(_excluded && {isNil "_action"})then{_actionTxt = "Excluded"};
if(_excluded && {_action == "none"})then{_actionTxt = "Excluded"};
if(_excluded && {_action != "none"})then{_actionTxt = _excludedText};
if(isNil "_action")				  then{_actionTxt = "not initialized"};
if(_action == "none")			  then{_actionTxt = ""};
if(_supp > SFSM_ProneTreshHold)	  then{_actionTxt = "! Suppressed !"};

if(fleeing _man
&&{!("hunker" in  _action)
&&{_action == "none"
&&{! _unconscious}}})then{
	_actionTxt = "Fleeing";
};

private _actColor	= [_actionTxt] call SFSM_fnc_actionColor;

/*
3D icons works in layers, the last one to be added is on the top.
Hence the action-text is placed last
*/

//incoming bullets
if(_rps > 1)
then{
		drawIcon3D 	[
						"",				//texture (icon type)
						_suppColor,		//color
						_incPos,		//position
						0.2, 			//size X
						0.2, 			//size Y
						0, 	 			//angle
						_incomingTxt, 	//text
						2, 				//shadow
						0.03			//textSize
					];
	};

//suppression level

if(_supp > 0)
then{
drawIcon3D 	[
				"",			
				_suppColor,	
				_supPos,	
				0.2, 		
				0.2, 		
				0, 	 		
				_supTxt, 	
				2, 			
				0.03		
			];
};

//current action

if!(_actionTxt == "")
then{
drawIcon3D 	[
				"",			
				_actColor,	
				_actionPos,	
				0.2, 		
				0.2, 		
				0, 	 		
				_actionTxt, 
				2, 			
				0.03		
			];
};

if(_excluded)
then{
	if(_action == "none")then{_actionTxt = ""}
	else{_actionTxt = _action};


	drawIcon3D 	[
					"\a3\ui_f\data\igui\cfg\simpletasks\letters\x_ca.paa",			
					[1,0,0,1],	
					ASLToAGL(aimPos _man),	
					0.5, 		
					0.5, 		
					0, 	 		
					_actionTxt, 
					2, 			
					0.1		
				];
};


if (_unconscious) then {
	drawIcon3D 	[
					"\A3\ui_f\data\map\mapcontrol\Bunker_CA.paa",		
					[0.49, 0.12, 0.12, 1],	
					ASLToAGL(aimPos _man),	
					1, 		
					1, 		
					0, 	 		
					"unconscious", 
					2, 			
					0.03		
				];
};

If(_sprinting)then {
	drawIcon3D 	[
					"\A3\ui_f\data\map\markers\military\ambush_CA.paa",		
					[0.2, 0.8, 0.2, 1],	
					ASLToAGL(aimPos _man),	
					0.5, 		
					0.5, 		
					0, 	 		
					"sprinting", 
					2, 			
					0.03		
				];
};

true;