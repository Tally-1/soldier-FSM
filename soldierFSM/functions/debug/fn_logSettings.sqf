private _smallTxt = "<t size='0.75'>";
private _versionName = ["soldier FSM V. ", SFSM_Version] joinString "";
private _signature = ["--> ", _versionName, " setting: "] joinString "";
private _outLine  = "<t shadow='2'>";
private _aqua     = "<t color='#00ffff'>";
private _khaki    = "<t color='#acffa4'>";
private _green    = "<t color='#83ff7f'>";
private _end      = "</t>";

private _hintText = parseText
(
	[
		_outLine,

		_aqua,
		"Debugger ",  SFSM_Debugger, "<br/>",
		"Hiding ",    SFSM_hideFromVehicles, "<br/>",
		"prone-treshHold ",     SFSM_ProneTreshHold,  "<br/>",
		"react-fire coolDown ", SFSM_reactFireCoolDown, "<br/>","<br/>",
		_end,

		_khaki,
		"Hunt Vehicles ",         SFSM_AtSpecHuntVehicles, "<br/>",
		"MG suppress clusters  ", SFSM_mgSuppressClusters, "<br/>",
		"Custom EH ",             SFSM_enableCustomEH, "<br/>","<br/>",
		_end,

		_green,
		"Flinching ",              SFSM_allowFlinching, "<br/>",
		"flinchCoolDown ",         SFSM_FlinchCoolDown, "<br/>",
		"flinchTreshHold ",        SFSM_FlinchTreshHold, "<br/>","<br/>",
		_end,

		_aqua,
		"Dodging ",             SFSM_allowDodging,    "<br/>",
		"Player group dodge  ", SFSM_PlayerGrpDodge,  "<br/>",
		"Exclude Zeus commanded units ", SFSM_ExcludeZcommand, "<br/>",
		"dodge-CoolDown ",      SFSM_DodgeCoolDown, "<br/>",
		"cover distance ",      SFSM_DodgeDistance, "<br/>",
		"dodge-timer ",         SFSM_DodgeTimer, "<br/>",
		"dodge Trigger ",       SFSM_RpsDodgeTrigger, "<br/>",
		"Sprint speed ",         SFSM_sprintSpeed, "<br/>",
		"force-dodge ",         SFSM_forceDodge, "<br/>","<br/>",
		_end,

		_green,
		"explosion Cover Radius ",SFSM_explosionCoverRad, "<br/>",
		"break Cover when Hit ",SFSM_breakCoverOnHit, "<br/>",
		"panic-coef ",          SFSM_panicCoef, "<br/>",
		"no-Cover-Panic ",      SFSM_noCoverPanic, "<br/>",
		"emergency Rearm ",     SFSM_emergencyRearm, "<br/>",
		"Knowledge needed for battle ", SFSM_KnowledgeToFight,"<br/>","<br/>",
		_end,

		_smallTxt, _versionName, _end,

		_end
 	] joinString ""
);

if(SFSM_Debugger)
then{hint _hintText};

diag_log ([_signature, "Debugger ",                     SFSM_Debugger]           joinString "");
diag_log ([_signature, "Flinching ",                    SFSM_allowFlinching]     joinString "");
diag_log ([_signature, "Dodging ",                      SFSM_allowDodging]       joinString "");

diag_log ([_signature, "Hiding ",                       SFSM_hideFromVehicles]   joinString "");
diag_log ([_signature, "Hunt Vehicles ",                SFSM_AtSpecHuntVehicles] joinString "");
diag_log ([_signature, "MG suppress clusters ",         SFSM_mgSuppressClusters] joinString "");

diag_log ([_signature, "Custom EH ",                    SFSM_enableCustomEH]    joinString "");
diag_log ([_signature, "Exclude Zeus commanded units ", SFSM_ExcludeZcommand]   joinString "");
diag_log ([_signature, "Player group dodge ",           SFSM_PlayerGrpDodge]    joinString "");

diag_log ([_signature, "flinchTreshHold ",              SFSM_FlinchTreshHold]   joinString "");
diag_log ([_signature, "flinchCoolDown ",               SFSM_FlinchCoolDown]    joinString "");
diag_log ([_signature, "prone-treshHold ",              SFSM_ProneTreshHold]    joinString "");

diag_log ([_signature, "dodge Trigger ",                SFSM_RpsDodgeTrigger]   joinString "");
diag_log ([_signature, "dodge-CoolDown ",               SFSM_DodgeCoolDown]     joinString "");
diag_log ([_signature, "dodge-distance ",               SFSM_DodgeDistance]     joinString "");

diag_log ([_signature, "dodge-timer ",                  SFSM_DodgeTimer]        joinString "");
diag_log ([_signature, "force-dodge ",                  SFSM_forceDodge]        joinString "");
diag_log ([_signature, "no-Cover-Panic ",               SFSM_noCoverPanic]      joinString "");

diag_log ([_signature, "react-fire coolDown ",          SFSM_reactFireCoolDown] joinString "");
diag_log ([_signature, "panic-coef ",                   SFSM_panicCoef]         joinString "");
diag_log ([_signature, "Knowledge To Fight ",           SFSM_KnowledgeToFight]  joinString "");
diag_log ([_signature, "Sprint speed ",                 SFSM_sprintSpeed]       joinString "");
diag_log ([_signature, "emergency Rearm ",              SFSM_emergencyRearm]    joinString "");

true;