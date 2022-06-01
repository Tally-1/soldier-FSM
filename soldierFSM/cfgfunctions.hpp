class CfgFunctions
{
	class SFSM
	{
		class misc
		{
			class HandleSuppression {file = "\soldierFSM\functions\misc\fn_HandleSuppression.sqf"};
			class TaskManager 		{file = "\soldierFSM\functions\misc\fn_TaskManager.sqf"};
			class StoreSuppression	{file = "\soldierFSM\functions\misc\fn_StoreSuppression.sqf"};
			class InitMan			{file = "\soldierFSM\functions\misc\fn_InitMan.sqf"};
			class onSuppression		{file = "\soldierFSM\functions\misc\fn_onSuppression.sqf"};
			class SuppressedEH		{file = "\soldierFSM\functions\misc\fn_SuppressedEH.sqf"};
			class Roll				{file = "\soldierFSM\functions\misc\fn_Roll.sqf"};
			class unitData			{file = "\soldierFSM\functions\misc\fn_unitData.sqf"};
			class sinCosPos			{file = "\soldierFSM\functions\misc\fn_sinCosPos.sqf"};
			class 3dDebug			{file = "\soldierFSM\functions\misc\fn_3dDebug.sqf"};
			class 3DdebugText		{file = "\soldierFSM\functions\misc\fn_3DdebugText.sqf"};
			
		};

		class dodging
		{
			class dodgeEnded		{file = "\soldierFSM\functions\dodging\fn_dodgeEnded.sqf"};
			class EndDodge			{file = "\soldierFSM\functions\dodging\fn_EndDodge.sqf"};
			class Dodge				{file = "\soldierFSM\functions\dodging\fn_Dodge.sqf"};
			class GetDodgePos		{file = "\soldierFSM\functions\dodging\fn_GetDodgePos.sqf"};
			class canDodge			{file = "\soldierFSM\functions\dodging\fn_canDodge.sqf"};
		};
		
		class flinching 
		{
			class canFlinch			{file = "\soldierFSM\functions\flinching\fn_canFlinch.sqf"};
			class endFlinch			{file = "\soldierFSM\functions\flinching\fn_endFlinch.sqf"};
			class flinch 			{file = "\soldierFSM\functions\flinching\fn_flinch.sqf"};
			class BigBulletFlinch	{file = "\soldierFSM\functions\flinching\fn_BigBulletFlinch.sqf"};
			class standardFlinch	{file = "\soldierFSM\functions\flinching\fn_standardFlinch.sqf"};
			
		};

		class init
		{
			class serverInit		{file = "\soldierFSM\functions\init\fn_serverInit.sqf"};
			class initClient		{file = "\soldierFSM\functions\init\fn_initClient.sqf"};
			class initSFSM			{file = "\soldierFSM\functions\init\fn_initSFSM.sqf"; 		postInit = 1};
		};
	};
};