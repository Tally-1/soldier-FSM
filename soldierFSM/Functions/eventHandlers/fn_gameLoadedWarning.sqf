private _versionName = ["soldier FSM V. ", SFSM_Version] joinString "";
		private _bigTxt = "<t size='1.7'>";
		private _medTxt = "<t size='1.2'>";
		private _smallTxt = "<t size='0.75'>";
		private _outLine  = "<t shadow='2'>";
		private _red      = "<t color='#f72222'>";
		private _khaki    = "<t color='#acffa4'>";
		private _green    = "<t color='#83ff7f'>";
		private _end      = "</t>";
		private _nLine    = "<br/>";
		private _warningText = parseText
		([
			_outLine, _bigTxt, _red, "!!Warning!!", _end,_end,_nLine,
			_khaki,"You just loaded the game. It has been reported by some users that",
			"DCO soldier fsm will sometimes cause the game to crash in ",
			_red,_medTxt, " single player",_end,_end," when saving and ",_red,_medTxt,"loading",_end,_end,
			" the game",_red,_medTxt," 2 or more",_end,_end," times.",_end,_nLine,
			_nLine,
			_green,"If you want the technical explanation contact us via discord or steam",_end,_nLine,
			_nLine,
			_end,_nLine,_smallTxt, _versionName, _end,
			_end

		] joinString "");

_warningText;