if(!isNil "SFSM_Custom3Dpositions")then{
private _color = [0.6,0.6,0.1,1];
private _icon  = "\A3\ui_f\data\map\markers\handdrawn\dot_CA.paa";
private _size  = 1; 
private _i = 0;
	{
		drawIcon3D 	[
						_icon,			
						_color,
						_x,	
						1, 		
						1, 		
						0, 	 		
						(str _i), 
						2, 			
						0.035
					];
		_i = _i+1;
	} forEach SFSM_Custom3Dpositions;

};