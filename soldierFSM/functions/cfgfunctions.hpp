class CfgFunctions
{
	class SFSM
	{
		class misc
		{
			
			
			class StoreSuppression		{file = "\SOLDIERFSM\functions\misc\fn_StoreSuppression.sqf"};
			class onSuppression			{file = "\SOLDIERFSM\functions\misc\fn_onSuppression.sqf"};
			class Roll					{file = "\SOLDIERFSM\functions\misc\fn_Roll.sqf"};
			class unitData				{file = "\SOLDIERFSM\functions\misc\fn_unitData.sqf"};
			class sinCosPos				{file = "\SOLDIERFSM\functions\misc\fn_sinCosPos.sqf"};
			
			class initReaction			{file = "\SOLDIERFSM\functions\misc\fn_initReaction.sqf"};
			class groupData				{file = "\SOLDIERFSM\functions\misc\fn_groupData.sqf"};
			class manAvailable          {file = "\SOLDIERFSM\functions\misc\fn_manAvailable.sqf"};
			class soundReaction         {file = "\SOLDIERFSM\functions\misc\fn_soundReaction.sqf"};
			class forceMoveToPos		{file = "\SOLDIERFSM\functions\misc\fn_forceMoveToPos.sqf"};
			class manLoaded             {file = "\SOLDIERFSM\functions\misc\fn_manLoaded.sqf"};
			class unitInDoor            {file = "\SOLDIERFSM\functions\misc\fn_unitInDoor.sqf"};
			class isRealMan             {file = "\SOLDIERFSM\functions\misc\fn_isRealMan.sqf"};
		};
		class taskManagement
		{
			class HandleSuppression 	{file = "\SOLDIERFSM\functions\taskManagement\fn_HandleSuppression.sqf"};
			class TaskManager           {file = "\SOLDIERFSM\functions\taskManagement\fn_TaskManager.sqf"};
			class tenSecondTasks		{file = "\SOLDIERFSM\functions\taskManagement\fn_tenSecondTasks.sqf"};
			class unitTasks				{file = "\SOLDIERFSM\functions\taskManagement\fn_unitTasks.sqf"};
			class groupTasks			{file = "\SOLDIERFSM\functions\taskManagement\fn_groupTasks.sqf"};
			class handleGroupStance     {file = "\SOLDIERFSM\functions\taskManagement\fn_handleGroupStance.sqf"};
			
		};

		class projectileHandling
		{
			class reactToExplosion      {file = "\SOLDIERFSM\functions\projectileHandling\fn_reactToExplosion.sqf"};
			class addCrater             {file = "\SOLDIERFSM\functions\projectileHandling\fn_addCrater.sqf"};
			class handleBulletImpact    {file = "\SOLDIERFSM\functions\projectileHandling\fn_handleBulletImpact.sqf"};
			class handleExplosion       {file = "\SOLDIERFSM\functions\projectileHandling\fn_handleExplosion.sqf"};
		};

		class curator
		{
			class zWPplaced             {file = "\SOLDIERFSM\functions\curator\fn_zWPplaced.sqf"};
			class zWPdeleted            {file = "\SOLDIERFSM\functions\curator\fn_zWPdeleted.sqf"};
		};
		
		class eventHandlers
		{
			class SuppressedEH			{file = "\SOLDIERFSM\functions\eventHandlers\fn_SuppressedEH.sqf"};
			class hitEH					{file = "\SOLDIERFSM\functions\eventHandlers\fn_hitEH.sqf"};
			class firedEH				{file = "\SOLDIERFSM\functions\eventHandlers\fn_firedEH.sqf"};
			class endHealEH				{file = "\SOLDIERFSM\functions\eventHandlers\fn_endHealEH.sqf"};
			class curatorEH             {file = "\SOLDIERFSM\functions\eventHandlers\fn_curatorEH.sqf"};
			class spottedCustomEH		{file = "\SOLDIERFSM\functions\eventHandlers\fn_spottedCustomEH.sqf"};
			class enemySpotted          {file = "\SOLDIERFSM\functions\eventHandlers\fn_enemySpotted.sqf"};
			class unitKilled            {file = "\SOLDIERFSM\functions\eventHandlers\fn_unitKilled.sqf"};
			class unitCreated           {file = "\SOLDIERFSM\functions\eventHandlers\fn_unitCreated.sqf"};
			class projectileEH			{file = "\SOLDIERFSM\functions\eventHandlers\fn_projectileEH.sqf"};
			class explosionEH			{file = "\SOLDIERFSM\functions\eventHandlers\fn_explosionEH.sqf"};
			class bulletEH			    {file = "\SOLDIERFSM\functions\eventHandlers\fn_bulletEH.sqf"};
			class vehicleFiredEh        {file = "\SOLDIERFSM\functions\eventHandlers\fn_vehicleFiredEh.sqf"};
			class enemyDetected			{file = "\SOLDIERFSM\functions\eventHandlers\fn_enemyDetected.sqf"};
			class gameLoaded            {file = "\SOLDIERFSM\functions\eventHandlers\fn_gameLoaded.sqf"; preInit = 1};
			class gameLoadedWarning     {file = "\SOLDIERFSM\functions\eventHandlers\fn_gameLoadedWarning.sqf";};
		};

		class dodging
		{
			class dodgeEnded			{file = "\SOLDIERFSM\functions\dodging\fn_dodgeEnded.sqf"};
			class EndDodge				{file = "\SOLDIERFSM\functions\dodging\fn_EndDodge.sqf"};
			class Dodge					{file = "\SOLDIERFSM\functions\dodging\fn_Dodge.sqf"};
			class GetDodgePos			{file = "\SOLDIERFSM\functions\dodging\fn_GetDodgePos.sqf"};
			class canDodge				{file = "\SOLDIERFSM\functions\dodging\fn_canDodge.sqf"};
			class getLateralPos			{file = "\SOLDIERFSM\functions\dodging\fn_getLateralPos.sqf"};
			class groupCanDodge         {file = "\SOLDIERFSM\functions\dodging\fn_groupCanDodge.sqf"};
			class forceCoverDodge       {file = "\SOLDIERFSM\functions\dodging\fn_forceCoverDodge.sqf"};
			
			
		};
		
		class flinching 
		{
			class canFlinch				{file = "\SOLDIERFSM\functions\flinching\fn_canFlinch.sqf"};
			class endFlinch				{file = "\SOLDIERFSM\functions\flinching\fn_endFlinch.sqf"};
			class flinch 				{file = "\SOLDIERFSM\functions\flinching\fn_flinch.sqf"};
			class bigBulletFlinch		{file = "\SOLDIERFSM\functions\flinching\fn_BigBulletFlinch.sqf"};
			class standardFlinch		{file = "\SOLDIERFSM\functions\flinching\fn_standardFlinch.sqf"};
			class execStandardFlinch	{file = "\SOLDIERFSM\functions\flinching\fn_execStandardFlinch.sqf"};
			class normalizeStance		{file = "\SOLDIERFSM\functions\flinching\fn_normalizeStance.sqf"};
			class bigFlinchCover        {file = "\SOLDIERFSM\functions\flinching\fn_bigFlinchCover.sqf"};
			
		};

		class reactiveFire
		{
			class canReactFire			{file = "\SOLDIERFSM\functions\reactiveFire\fn_canReactFire.sqf"};
			class reactFire				{file = "\SOLDIERFSM\functions\reactiveFire\fn_reactFire.sqf"};
			class endReactiveFire		{file = "\SOLDIERFSM\functions\reactiveFire\fn_endReactiveFire.sqf"};
			class directReactFire		{file = "\SOLDIERFSM\functions\reactiveFire\fn_directReactFire.sqf"};
			class unitTounitForcedFire	{file = "\SOLDIERFSM\functions\reactiveFire\fn_unitTounitForcedFire.sqf"};
			class unitAimedAtTarget		{file = "\SOLDIERFSM\functions\reactiveFire\fn_unitAimedAtTarget.sqf"};
			class unitWeaponDir			{file = "\SOLDIERFSM\functions\reactiveFire\fn_unitWeaponDir.sqf"};
			class multiplyReactionFire	{file = "\SOLDIERFSM\functions\reactiveFire\fn_multiplyReactionFire.sqf"};
		};

		class startEngagement
		{
			//cover-folder
			class getCoverPos            {file = "\SOLDIERFSM\functions\startEngagement\takeCover\fn_getCoverPos.sqf"};
			class fightInitCover		 {file = "\SOLDIERFSM\functions\startEngagement\takeCover\fn_fightInitCover.sqf"};
			class takeCover				 {file = "\SOLDIERFSM\functions\startEngagement\takeCover\fn_takeCover.sqf"};
			class endTakeCover        	 {file = "\SOLDIERFSM\functions\startEngagement\takeCover\fn_endTakeCover.sqf"};
			class selectCoverPos         {file = "\SOLDIERFSM\functions\startEngagement\takeCover\fn_selectCoverPos.sqf"};
			class postCoverActions       {file = "\SOLDIERFSM\functions\startEngagement\takeCover\fn_postCoverActions.sqf"};
			class initTakeCover          {file = "\SOLDIERFSM\functions\startEngagement\takeCover\fn_initTakeCover.sqf"};
			class stayInCover            {file = "\SOLDIERFSM\functions\startEngagement\takeCover\fn_stayInCover.sqf"};
			class endStayInCover         {file = "\SOLDIERFSM\functions\startEngagement\takeCover\fn_endStayInCover.sqf"};
			class eventTriggeredCover    {file = "\SOLDIERFSM\functions\startEngagement\takeCover\fn_eventTriggeredCover.sqf"};

			//hide-folder
			class findHidePos            {file = "\SOLDIERFSM\functions\startEngagement\hide\fn_findHidePos.sqf"};
			class hideFromVehicle        {file = "\SOLDIERFSM\functions\startEngagement\hide\fn_hideFromVehicle.sqf"};
			class initHideFromVeh        {file = "\SOLDIERFSM\functions\startEngagement\hide\fn_initHideFromVeh.sqf"};
			class moveToHidePos          {file = "\SOLDIERFSM\functions\startEngagement\hide\fn_moveToHidePos.sqf"};

			//this-folder
			class AtSpecialistInitFight  {file = "\SOLDIERFSM\functions\startEngagement\fn_AtSpecialistInitFight.sqf"};
			class targetInfWithLauncher  {file = "\SOLDIERFSM\functions\startEngagement\fn_targetInfWithLauncher.sqf"};
			class reactTovehicles        {file = "\SOLDIERFSM\functions\startEngagement\fn_reactTovehicles.sqf"};
			class unkillableEnemyVehicle {file = "\SOLDIERFSM\functions\startEngagement\fn_unkillableEnemyVehicle.sqf"};
			class eyelidTrench			 {file = "\SOLDIERFSM\functions\startEngagement\fn_eyelidTrench.sqf"};
			class getEnemyVehicles       {file = "\SOLDIERFSM\functions\startEngagement\fn_getEnemyVehicles.sqf"};
			class specialInitFightActions{file = "\SOLDIERFSM\functions\startEngagement\fn_specialInitFightActions.sqf"};
			class machineGunInitFight    {file = "\SOLDIERFSM\functions\startEngagement\fn_machineGunInitFight.sqf"};
			class supressPositions       {file = "\SOLDIERFSM\functions\startEngagement\fn_supressPositions.sqf"};
		}

		class init
		{
			class serverInit			{file = "\SOLDIERFSM\functions\init\fn_serverInit.sqf"};
			class initSettings			{file = "\SOLDIERFSM\functions\init\fn_initSettings.sqf"};
			class postConfig			{file = "\SOLDIERFSM\functions\init\fn_postConfig.sqf"};
			class initClient			{file = "\SOLDIERFSM\functions\init\fn_initClient.sqf"};
			class initSFSM				{file = "\SOLDIERFSM\functions\init\fn_initSFSM.sqf"; 		postInit = 1};
			class InitMan				{file = "\SOLDIERFSM\functions\init\fn_InitMan.sqf"};
			class initGroup             {file = "\SOLDIERFSM\functions\init\fn_initGroup.sqf"};
		};

		class debug
		{
			class 3dDebug				{file = "\SOLDIERFSM\functions\debug\fn_3dDebug.sqf"};
			class 3DdebugText			{file = "\SOLDIERFSM\functions\debug\fn_3DdebugText.sqf"};
			class actionColor			{file = "\SOLDIERFSM\functions\debug\fn_actionColor.sqf"};
			class drawObjectMarker      {file = "\SOLDIERFSM\functions\debug\fn_drawObjectMarker.sqf"};
			class multiple3dmarkers     {file = "\SOLDIERFSM\functions\debug\fn_multiple3dmarkers.sqf"};
			class battlefield3d			{file = "\SOLDIERFSM\functions\debug\fn_battlefield3d.sqf"};
			class man3dInfo             {file = "\SOLDIERFSM\functions\debug\fn_man3dInfo.sqf"};
			class debugMessage			{file = "\SOLDIERFSM\functions\debug\fn_debugMessage.sqf"};
			class hunkerObj3d			{file = "\SOLDIERFSM\functions\debug\fn_hunkerObj3d.sqf"};
			class manInfo               {file = "\SOLDIERFSM\functions\debug\fn_manInfo.sqf"};
			class logSettings           {file = "\SOLDIERFSM\functions\debug\fn_logSettings.sqf"};
			class deleteWarning         {file = "\SOLDIERFSM\functions\debug\fn_deleteWarning.sqf"};
		};
		
		class healing
		{
			class proneHeal				{file = "\SOLDIERFSM\functions\healing\fn_proneHeal.sqf"};
			class endSelfHeal			{file = "\SOLDIERFSM\functions\healing\fn_endSelfHeal.sqf"};
			class canSelfHeal			{file = "\SOLDIERFSM\functions\healing\fn_canSelfHeal.sqf"};
		};
		class battlefield
		{
			class InitBattlefield		  {file = "\SOLDIERFSM\functions\battlefield\fn_InitBattlefield.sqf"};
			class battlefieldPostInit	  {file = "\SOLDIERFSM\functions\battlefield\fn_battlefieldPostInit.sqf"};
			class battlefieldEnd		  {file = "\SOLDIERFSM\functions\battlefield\fn_battlefieldEnd.sqf"};
			class getZones				  {file = "\SOLDIERFSM\functions\battlefield\fn_getZones.sqf"};
			class getZone				  {file = "\SOLDIERFSM\functions\battlefield\fn_getZone.sqf"};
			class getCoverPositionsLight  {file = "\SOLDIERFSM\functions\battlefield\fn_getCoverPositionsLight.sqf"};
			class clusterCoverPosLight    {file = "\SOLDIERFSM\functions\battlefield\fn_clusterCoverPosLight.sqf"};
			class battlefieldRadius       {file = "\SOLDIERFSM\functions\battlefield\fn_battlefieldRadius.sqf"};
			class nearestBattle			  {file = "\SOLDIERFSM\functions\battlefield\fn_nearestBattle.sqf"};
			class battleInitType          {file = "\SOLDIERFSM\functions\battlefield\fn_battleInitType.sqf"};
			class battlefieldVariables    {file = "\SOLDIERFSM\functions\battlefield\fn_battlefieldVariables.sqf"};
			class updateBattlefield       {file = "\SOLDIERFSM\functions\battlefield\fn_updateBattlefield.sqf"};
			class sidesFromString         {file = "\SOLDIERFSM\functions\battlefield\fn_sidesFromString.sqf"};
			class battlingUnits           {file = "\SOLDIERFSM\functions\battlefield\fn_battlingUnits.sqf"};
			class battleEnded             {file = "\SOLDIERFSM\functions\battlefield\fn_battleEnded.sqf"};
			class battleFieldUpdater      {file = "\SOLDIERFSM\functions\battlefield\fn_battleFieldUpdater.sqf"};
			class triggerBattleOnShot	  {file = "\SOLDIERFSM\functions\battlefield\fn_triggerBattleOnShot.sqf"};
			class canTriggerBattleShot	  {file = "\SOLDIERFSM\functions\battlefield\fn_canTriggerBattleShot.sqf"};
			class canSpotInitBattle       {file = "\SOLDIERFSM\functions\battlefield\fn_canSpotInitBattle.sqf"};
			class excludeCpos  			  {file = "\SOLDIERFSM\functions\battlefield\fn_excludeCpos.sqf"};
			class getBattlefield		  {file = "\SOLDIERFSM\functions\battlefield\fn_getBattlefield.sqf"};
			class getEnemyPositions		  {file = "\SOLDIERFSM\functions\battlefield\fn_getEnemyPositions.sqf"};
			class updateHunkerObjects	  {file = "\SOLDIERFSM\functions\battlefield\fn_updateHunkerObjects.sqf"};
			class initGrid                {file = "\SOLDIERFSM\functions\battlefield\fn_initGrid.sqf"};
			class updateGrid              {file = "\SOLDIERFSM\functions\battlefield\fn_updateGrid.sqf"};
			class AddWeaponsToBattlefield {file = "\SOLDIERFSM\functions\battlefield\fn_AddWeaponsToBattlefield.sqf"};
			class emergencyRearm          {file = "\SOLDIERFSM\functions\battlefield\fn_emergencyRearm.sqf"};
			class getBattlefieldWeapon    {file = "\SOLDIERFSM\functions\battlefield\fn_getBattlefieldWeapon.sqf"};
			class pickUpWeapon            {file = "\SOLDIERFSM\functions\battlefield\fn_pickUpWeapon.sqf"};
			class canPickUpWeapon         {file = "\SOLDIERFSM\functions\battlefield\fn_canPickUpWeapon.sqf"};
			class endWeaponPickup         {file = "\SOLDIERFSM\functions\battlefield\fn_endWeaponPickup.sqf"};
			class useLightScan            {file = "\SOLDIERFSM\functions\battlefield\fn_useLightScan.sqf"};
		};
		
		class markers
		{
			class posMarker				{file = "\SOLDIERFSM\functions\markers\fn_posMarker.sqf"};
			class drawCircle			{file = "\SOLDIERFSM\functions\markers\fn_drawCircle.sqf"};
			class bfDebugMarkers		{file = "\SOLDIERFSM\functions\markers\fn_bfDebugMarkers.sqf"};
			class drawCoverPositions	{file = "\SOLDIERFSM\functions\markers\fn_drawCoverPositions.sqf"};
		};

		class objectData
		{
			class glRifle				{file = "\SOLDIERFSM\functions\objectData\fn_glRifle.sqf"};
			class ObjStance				{file = "\SOLDIERFSM\functions\objectData\fn_ObjStance.sqf"};
			class areaData				{file = "\SOLDIERFSM\functions\objectData\fn_areaData.sqf"};
			class getMapObjects			{file = "\SOLDIERFSM\functions\objectData\fn_getMapObjects.sqf"};
			class excludedMapObject		{file = "\SOLDIERFSM\functions\objectData\fn_excludedMapObject.sqf"};
			class filterMapObjects		{file = "\SOLDIERFSM\functions\objectData\fn_filterMapObjects.sqf"};
			class terrainObjData		{file = "\SOLDIERFSM\functions\objectData\fn_terrainObjData.sqf"};
			class squadAsset			{file = "\SOLDIERFSM\functions\objectData\fn_squadAsset.sqf"};
			class hasAmmoForWeapon      {file = "\SOLDIERFSM\functions\objectData\fn_hasAmmoForWeapon.sqf"};
		};
		class hunkerDown
		{
			class getHunkerObject		{file = "\SOLDIERFSM\functions\hunkerDown\fn_getHunkerObject.sqf"};
			class initHunker			{file = "\SOLDIERFSM\functions\hunkerDown\fn_initHunker.sqf"};
			class isHunkerObject        {file = "\SOLDIERFSM\functions\hunkerDown\fn_isHunkerObject.sqf"};
			class hunkAvailable			{file = "\SOLDIERFSM\functions\hunkerDown\fn_hunkAvailable.sqf"};
			class getAvHunkObject		{file = "\SOLDIERFSM\functions\hunkerDown\fn_getAvHunkObject.sqf"};
			class filterHunkerObjects	{file = "\SOLDIERFSM\functions\hunkerDown\fn_filterHunkerObjects.sqf"};
			class hunkObjHash	        {file = "\SOLDIERFSM\functions\hunkerDown\fn_hunkObjHash.sqf"};
			class hunkerFSM				{file = "\SOLDIERFSM\functions\hunkerDown\fn_hunkerFSM.sqf"};
			class hunkerFsmStatus		{file = "\SOLDIERFSM\functions\hunkerDown\fn_hunkerFsmStatus.sqf"};
			class addHunkerObjData		{file = "\SOLDIERFSM\functions\hunkerDown\fn_addHunkerObjData.sqf"};
			class setHobjPositions		{file = "\SOLDIERFSM\functions\hunkerDown\fn_setHobjPositions.sqf"};
			class moveToHunkerPos		{file = "\SOLDIERFSM\functions\hunkerDown\fn_moveToHunkerPos.sqf"};
			class endHunker				{file = "\SOLDIERFSM\functions\hunkerDown\fn_endHunker.sqf"};
			class initHunkerFSM			{file = "\SOLDIERFSM\functions\hunkerDown\fn_initHunkerFSM.sqf"};
			class handleHunkerStatus	{file = "\SOLDIERFSM\functions\hunkerDown\fn_handleHunkerStatus.sqf"};
			class randomHunkerInit		{file = "\SOLDIERFSM\functions\hunkerDown\fn_randomHunkerInit.sqf"};

		};
	};

	class Tcore
	{
		class core
		{
			
			
			class average				{file = "\SOLDIERFSM\functions\core\fn_average.sqf"};
			class decimals				{file = "\SOLDIERFSM\functions\core\fn_decimals.sqf"};
			class addZ					{file = "\SOLDIERFSM\functions\core\fn_addZ.sqf"};
			class roundPos				{file = "\SOLDIERFSM\functions\core\fn_roundPos.sqf"};
			class avgPos				{file = "\SOLDIERFSM\functions\core\fn_avgPos.sqf"};
			class get360Positions		{file = "\SOLDIERFSM\functions\core\fn_get360Positions.sqf"};
			class nearestPos			{file = "\SOLDIERFSM\functions\core\fn_nearestPos.sqf"};
			class getMidpoint           {file = "\SOLDIERFSM\functions\core\fn_getMidpoint.sqf"};
			class sinCosPos				{file = "\SOLDIERFSM\functions\core\fn_sinCosPos.sqf"};
			
			class formatDir 			{file = "\SOLDIERFSM\functions\core\fn_formatDir.sqf"};
			class avgRelDir				{file = "\SOLDIERFSM\functions\core\fn_avgRelDir.sqf"};
			class inDirRange 			{file = "\SOLDIERFSM\functions\core\fn_inDirRange.sqf"};
			
			class object3DShape			{file = "\SOLDIERFSM\functions\core\fn_object3DShape.sqf"};
			class objPosData			{file = "\SOLDIERFSM\functions\core\fn_objPosData.sqf"};
			class simpleObjectType		{file = "\SOLDIERFSM\functions\core\fn_simpleObjectType.sqf"};

			class clusterPos			{file = "\SOLDIERFSM\functions\core\fn_clusterPos.sqf"};
			class allClustersInRadius	{file = "\SOLDIERFSM\functions\core\fn_allClustersInRadius.sqf"};
			class ClusterTerrainObjects	{file = "\SOLDIERFSM\functions\core\fn_ClusterTerrainObjects.sqf"};
			class positionsClusterArr	{file = "\SOLDIERFSM\functions\core\fn_positionsClusterArr.sqf"};
			class clusterSize			{file = "\SOLDIERFSM\functions\core\fn_clusterSize.sqf"};
			class clusterMarker			{file = "\SOLDIERFSM\functions\core\fn_clusterMarker.sqf"};
			class ClusterSides			{file = "\SOLDIERFSM\functions\core\fn_ClusterSides.sqf"};
			
			class ClusterUnits			{file = "\SOLDIERFSM\functions\core\fn_ClusterUnits.sqf"};
			class ClusterVehicles		{file = "\SOLDIERFSM\functions\core\fn_ClusterVehicles.sqf"};
			class clusterGroups         {file = "\SOLDIERFSM\functions\core\fn_clusterGroups.sqf"};

			class unitCoverPosArr		{file = "\SOLDIERFSM\functions\core\fn_unitCoverPosArr.sqf"};
			class posCoverPosArr		{file = "\SOLDIERFSM\functions\core\fn_posCoverPosArr.sqf"};
			class coverPosStance		{file = "\SOLDIERFSM\functions\core\fn_coverPosStance.sqf"};
			class objCoverPosLight		{file = "\SOLDIERFSM\functions\core\fn_objCoverPosLight.sqf"};
			class coverPosSimple		{file = "\SOLDIERFSM\functions\core\fn_coverPosSimple.sqf"};
			class visibleFromPositions	{file = "\SOLDIERFSM\functions\core\fn_visibleFromPositions.sqf"};
			
			class debugMessage			{file = "\SOLDIERFSM\functions\core\fn_debugMessage.sqf"};
			class closestLocationName	{file = "\SOLDIERFSM\functions\core\fn_closestLocationName.sqf"};
			class getLocationNamePos	{file = "\SOLDIERFSM\functions\core\fn_getLocationNamePos.sqf"};
			
			class describeDir			{file = "\SOLDIERFSM\functions\core\fn_describeDir.sqf"};
			class describeDistance		{file = "\SOLDIERFSM\functions\core\fn_describeDistance.sqf"};
			class stringToVarName		{file = "\SOLDIERFSM\functions\core\fn_stringToVarName.sqf"};
			class areaName				{file = "\SOLDIERFSM\functions\core\fn_areaName.sqf"};			
			
			class toArrFromArr			{file = "\SOLDIERFSM\functions\core\fn_toArrFromArr.sqf"};
			
			class nearKnownEnemies      {file = "\SOLDIERFSM\functions\core\fn_nearKnownEnemies.sqf"};
			class knownDirToEnemy       {file = "\SOLDIERFSM\functions\core\fn_knownDirToEnemy.sqf"};
			class getLosTarget			{file = "\SOLDIERFSM\functions\core\fn_getLosTarget.sqf"};
			class deadCrew				{file = "\SOLDIERFSM\functions\core\fn_deadCrew.sqf"};
			class grid100Pos            {file = "\SOLDIERFSM\functions\core\fn_grid100Pos.sqf"};
			class substringsPresent     {file = "\SOLDIERFSM\functions\core\fn_substringsPresent.sqf"};
			class playerLedGrp          {file = "\SOLDIERFSM\functions\core\fn_playerLedGrp.sqf"};
			class isPlayer				{file = "\SOLDIERFSM\functions\core\fn_isPlayer.sqf"};

			class toggleAiMoveInhibitors{file = "\SOLDIERFSM\functions\core\fn_toggleAiMoveInhibitors.sqf"};
			class deadMenInArea         {file = "\SOLDIERFSM\functions\core\fn_deadMenInArea.sqf"};
			class nearSoldiers          {file = "\SOLDIERFSM\functions\core\fn_nearSoldiers.sqf"};

			class nilNull				{file = "\SOLDIERFSM\functions\core\fn_nilNull.sqf"};
		};
	};
};